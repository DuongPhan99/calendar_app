import 'package:flutter/material.dart';

class CustomRasiedButton extends StatelessWidget {
  CustomRasiedButton(
      {this.borderRadius: 40.0,
      this.child,
      this.color,
      this.onPressed,
      this.height: 60.0})
      : assert(borderRadius != null);
  final Widget child;
  final Color color;
  final double height;
  final double borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        child: child,
        disabledColor: color,
        elevation: 0.6,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}
