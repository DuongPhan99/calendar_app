import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_time_app/common_widget/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(BuildContext context,
        {@required String title, @required Exception exception}) =>
    showAlertDialog(context,
        title: title, content: _message(exception), defaultActionText: "ok");

String _message(Exception exception) {
  if (exception is FirebaseAuthException) {
    return exception.message;
  }
  return exception.toString();
}
