import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:splitter/Widgets/NullWidget.dart';

class LoginErrorMessage extends StatelessWidget {
  LoginErrorMessage({@required this.stream});

  final Stream<String> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: PlatformText(
                  snapshot.data,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.red,
                      height: 1.0,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
              )
          );
        } else {
          return NullWidget();
        }
      }
    );
  }
}