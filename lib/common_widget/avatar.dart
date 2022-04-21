import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String photo;
  final double radius;

  const Avatar({Key key, this.photo, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        backgroundImage: photo != null ? NetworkImage(photo) : null,
        backgroundColor: Colors.black12,
        child: photo == null
            ? Icon(
                Icons.camera_alt,
                size: radius,
              )
            : null);
  }
}
