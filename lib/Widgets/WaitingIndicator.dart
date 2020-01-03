import 'package:flutter/material.dart';

class WaitingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
                color: Colors.black38,
                alignment: Alignment.center,
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
            );
  }
}