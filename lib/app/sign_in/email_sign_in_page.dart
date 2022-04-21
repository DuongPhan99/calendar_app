import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/sign_in/email_sign_in_form_bloc_base.dart';
import 'package:flutter_time_app/app/sign_in/email_sign_in_form_statefull.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign In Email",
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(child: EmailSignInFormBlocBase.create(context)),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
