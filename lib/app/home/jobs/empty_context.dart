import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String title;
  final String message;
  EmptyContent(
      {Key key,
      @required this.message = "Add a new item to get started",
      @required this.title = "Nothing Here"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 32.0,
            ),
          ),
          Text(
            message,
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          )
        ],
      ),
    );
  }
}
