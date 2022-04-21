import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/sign_in/email_sign_in_bloc.dart';
import 'package:flutter_time_app/app/sign_in/email_sign_in_model.dart';

import 'package:flutter_time_app/common_widget/form_summit_button.dart';

import 'package:flutter_time_app/common_widget/show_exception_alert_dialog.dart';
import 'package:flutter_time_app/services/auth.dart';

import 'package:provider/provider.dart';

class EmailSignInFormBlocBase extends StatefulWidget {
  EmailSignInFormBlocBase({@required this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (context) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBase(
          bloc: bloc,
        ),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  State<EmailSignInFormBlocBase> createState() =>
      _EmailSignInFormBlocBaseState();
}

class _EmailSignInFormBlocBaseState extends State<EmailSignInFormBlocBase> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _summit() async {
    try {
      await widget.bloc.summit();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, title: "Sign in faild", exception: e);
    }
  }

  void _toggleFormType() {
    widget.bloc.toggleFromType();

    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingFocus(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocus
        : _emailFocus;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailTextField(model),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(model),
      SizedBox(
        height: 8.0,
      ),
      FormSummitButton(
        text: model.primaryButtonText,
        onPressed: model.canSummit ? _summit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
          onPressed: !model.isLoading ? _toggleFormType : null,
          child: Text(model.secondaryButtonText))
    ];
  }

  Widget _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      focusNode: _passwordFocus,
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      obscureText: true,
      onChanged: widget.bloc.upDatePassword,
      onEditingComplete: _summit,
      decoration: InputDecoration(
          label: Text("Password"), errorText: model.passwordErrorText),
    );
  }

  Widget _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      focusNode: _emailFocus,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onEditingComplete: () => _emailEditingFocus(model),
      onChanged: widget.bloc.upDateEmail,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "test@test.com",
          label: Text("Email"),
          errorText: model.EmailErrorText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
