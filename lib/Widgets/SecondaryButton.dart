import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({@required this.text, @required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: FlatButton(
                child: Text(
                    text,
                    style: TextStyle(fontSize: 18.0,
                                     fontWeight: FontWeight.w300,
                                     color: Colors.black
                            )
                ),
                onPressed: onPressed
            )
    );
  }
}