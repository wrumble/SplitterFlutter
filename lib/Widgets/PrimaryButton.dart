import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({@required this.text, @required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: PlatformButton(
            color: Colors.blue,
            child: Text(
                text,
                style: TextStyle(fontSize: 22.0, color: Colors.white)),
            onPressed: onPressed,
          ),
      );
  }
}