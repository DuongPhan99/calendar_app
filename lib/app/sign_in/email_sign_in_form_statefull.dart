import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/sign_in/email_sign_in_model.dart';
import 'package:flutter_time_app/app/sign_in/validator.dart';
import 'package:flutter_time_app/common_widget/form_summit_button.dart';

import 'package:flutter_time_app/common_widget/show_exception_alert_dialog.dart';
import 'package:flutter_time_app/services/auth.dart';

import 'package:provider/provider.dart';

class EmailSignInFormStateFull extends StatefulWidget
    with EmailAndPasswordValidator {
  @override
  State<EmailSignInFormStateFull> createState() =>
      _EmailSignInFormStateFullState();
}

class _EmailSignInFormStateFullState extends State<EmailSignInFormStateFull> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool _summited = false;
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _summit() async {
    setState(() {
      _summited = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createrWithEmailAndPassword(_email, _password);
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, title: "Sign in faild", exception: e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleFormType() {
    setState(() {
      _summited = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingFocus() {
    final newFocus =
        widget.emailValidator.isValid(_email) ? _passwordFocus : _emailFocus;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? "Sign in"
        : "Creater an account";
    final secondText = _formType == EmailSignInFormType.signIn
        ? "Need an account? Register"
        : "Have an account? Sign In";
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 8.0,
      ),
      FormSummitButton(
        text: primaryText,
        onPressed: submitEnabled ? _summit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
          onPressed: !_isLoading ? _toggleFormType : null,
          child: Text(secondText))
    ];
  }

  Widget _buildPasswordTextField() {
    bool showErrorText = _summited && !widget.emailValidator.isValid(_password);
    return TextField(
      focusNode: _passwordFocus,
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      obscureText: true,
      onChanged: (password) => _updateState(),
      onEditingComplete: _summit,
      decoration: InputDecoration(
          label: Text("Password"),
          errorText: showErrorText ? widget.invalidPasswordErrorText : null),
    );
  }

  Widget _buildEmailTextField() {
    bool showErroText = _summited && !widget.passwordValidator.isValid(_email);
    return TextField(
      focusNode: _emailFocus,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onEditingComplete: _emailEditingFocus,
      onChanged: (email) => _updateState(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "test@test.com",
          label: Text("Email"),
          errorText: showErroText ? widget.invalidEmailErrorText : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }
}
