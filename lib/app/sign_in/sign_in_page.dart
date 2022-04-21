import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_app/app/sign_in/email_sign_in_page.dart';
import 'package:flutter_time_app/app/sign_in/sign_in_bloc.dart';
import 'package:flutter_time_app/app/sign_in/social_sign_in_button.dart';
import 'package:flutter_time_app/common_widget/show_exception_alert_dialog.dart';
import 'package:flutter_time_app/services/auth.dart';

import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final SignInBloc bloc;
  const SignInPage({Key key, @required this.bloc}) : super(key: key);
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
        create: (_) => SignInBloc(auth: auth),
        dispose: (_, bloc) => bloc.dispose(),
        child: Consumer<SignInBloc>(
          builder: (_, bloc, __) => SignInPage(bloc: bloc),
        ));
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: "Sign in faile", exception: exception);
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
      bloc.setIsLoading(false);
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await bloc.signInWithFacebook();
      bloc.setIsLoading(false);
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
          fullscreenDialog: true, builder: (context) => EmailSignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContext(context, snapshot.data);
          }),
    );
  }

  Widget _buildContext(BuildContext context, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 100.0, child: _buildHeader(isLoading)),
          SizedBox(
            height: 20.0,
          ),
          Text.rich(
            TextSpan(
                style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 3.0,
                    height: 1.03,
                    color: Color(0xff21899c)),
                children: <TextSpan>[
                  TextSpan(
                      text: "LOGIN",
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: "PAGE",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xfffe9879)))
                ]),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          SocialSignInButton(
            assetName: "assets/images/google-logo.png",
            text: "Sign in with Google",
            textColor: Color(0xff42899c),
            color: Colors.white,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 10.0,
          ),
          SocialSignInButton(
            assetName: "assets/images/facebook-logo.png",
            text: "Sign in with Facebook",
            textColor: Colors.white,
            color: Color(0xff3D73EB),
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: "assets/images/email1.png",
            text: "Sign in with Email",
            textColor: Colors.black,
            color: Color(0xffD2E3CC),
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return SvgPicture.asset(
      "assets/logo/logo.svg",
      width: 100.0,
      height: 100.0,
    );
  }
}
