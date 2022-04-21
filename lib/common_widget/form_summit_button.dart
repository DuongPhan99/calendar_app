import 'package:flutter/cupertino.dart';
import 'package:flutter_time_app/common_widget/custom_rasied_button.dart';
import 'package:flutter/material.dart';

class FormSummitButton extends CustomRasiedButton {
  FormSummitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            height: 44.0,
            color: Colors.indigo,
            borderRadius: 4.0,
            onPressed: onPressed);
}
