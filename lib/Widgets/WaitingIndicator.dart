import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class WaitingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
                color: Colors.black26,
                alignment: Alignment.center,
                child: PlatformCircularProgressIndicator (
                            android: (_) => MaterialProgressIndicatorData(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            ios: (_)=> CupertinoProgressIndicatorData(),
                )
            );
  }
}