import 'dart:async';

import 'package:flutter_time_app/app/sign_in/email_sign_in_model.dart';
import 'package:flutter_time_app/services/auth.dart';

class EmailSignInBloc {
  final AuthBase auth;
  EmailSignInBloc({this.auth});
  final StreamController<EmailSignInModel> _modelController =
      StreamController();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();
  void dispose() {
    _modelController.close();
  }

  Future<void> summit() async {
    updateWith(summit: true, isLoading: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createrWithEmailAndPassword(_model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: true);
      rethrow;
    }
  }

  void upDateEmail(String email) => updateWith(email: email);
  void upDatePassword(String password) => updateWith(password: password);
  void toggleFromType() {
    final fontype = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
        email: " ",
        password: " ",
        formType: fontype,
        isLoading: false,
        summit: false);
  }

  void updateWith(
      {String email,
      String password,
      bool summit,
      bool isLoading,
      EmailSignInFormType formType}) {
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        summit: summit,
        isLoading: isLoading);
    _modelController.add(_model);
  }
}
