import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_app/common_widget/avatar.dart';
import 'package:flutter_time_app/services/auth.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/show_alert_dialog.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confimSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: "Sign Out",
        content: "Are you sure that you want to logout",
        defaultActionText: "Logout",
        cancelActionText: "Cancel");
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Account",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FlatButton(
            onPressed: () => _confimSignOut(context),
            child: Text("LogOut",
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: _buildUserInfor(auth.currentUser),
        ),
      ),
    );
  }

  Widget _buildUserInfor(User user) {
    return Column(
      children: <Widget>[
        Avatar(
          photo: user.photoURL,
          radius: 50,
        ),
        SizedBox(
          height: 8.0,
        ),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}
