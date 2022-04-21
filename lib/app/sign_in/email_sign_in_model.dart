import 'package:flutter_time_app/app/sign_in/validator.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidator {
  EmailSignInModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.summit = false});
  final String email;
  final String password;
  final bool summit;
  final bool isLoading;
  final EmailSignInFormType formType;
  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? "Sign in"
        : "Creater an account";
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? "Need an account? Register"
        : "Have an account? Sign In";
  }

  bool get canSummit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = summit && !emailValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get EmailErrorText {
    bool showErroText = summit && !passwordValidator.isValid(email);
    return showErroText ? invalidEmailErrorText : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    bool summit,
    bool isLoading,
    EmailSignInFormType formType,
  }) {
    return EmailSignInModel(
        email: email ?? this.email,
        password: password ?? this.password,
        summit: summit ?? this.summit,
        formType: formType ?? this.formType);
  }
}
