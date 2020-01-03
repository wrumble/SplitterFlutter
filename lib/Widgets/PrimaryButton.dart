import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({@required this.text, @required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: Text(
                text,
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: onPressed,
          ),
        )
      );
  }
}