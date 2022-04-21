import 'package:flutter/material.dart';
import '../../common_widget/custom_rasied_button.dart';

class SocialSignInButton extends CustomRasiedButton {
  SocialSignInButton(
      {@required String text,
      Color color,
      Color textColor,
      VoidCallback onPressed,
      @required String assetName})
      : assert(text != null),
        assert(assetName != null),
        super(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(assetName),
                  Text(
                    text,
                    style: TextStyle(color: textColor, fontSize: 15.0),
                  ),
                  Opacity(opacity: 0.0, child: Image.asset(assetName)),
                ],
              ),
            ),
            color: color,
            onPressed: onPressed);
}
