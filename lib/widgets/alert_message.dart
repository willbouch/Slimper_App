import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {
  final String title;
  final String message;

  AlertMessage({this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyText1
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}
