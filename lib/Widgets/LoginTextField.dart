import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField(this.icon,
                 this.hintText, 
                 this.onChanged,
                 {this.obscureText = false,
                  this.keyboardType = TextInputType.text,
                  this.textCapitalization = TextCapitalization.none});

  final IconData icon;
  final String hintText;
  final Function(String) onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return textFieldForPlatform();
  }

  Widget textFieldForPlatform() {
    if (Platform.isIOS) {
      return iosTextField();
    } else {
      return androidTextField();
    }
  }

  Stack iosTextField() {
    return Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: PlatformTextField(
              maxLines: 1,
              textCapitalization: textCapitalization,
              obscureText: obscureText,
              autofocus: false,
              onChanged: onChanged,
              cursorColor: Colors.black,
              style: TextStyle(fontSize: 25),
              ios: (_) => CupertinoTextFieldData(decoration: BoxDecoration(color: Colors.black12.withAlpha(15), 
                                                                           border: Border.all(color: Colors.black12.withAlpha(15)), 
                                                                                              borderRadius: BorderRadius.all(Radius.circular(5))),
                                                 ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
            child: PlatformText(hintText,
                                style: TextStyle(fontSize: 16)
                   )
          )
        ],
      );
  }

  Padding androidTextField() {
    return Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
          child: TextFormField(
            textCapitalization: textCapitalization,
            maxLines: 1,
            obscureText: obscureText,
            autofocus: false,
            decoration: InputDecoration(
                hintText: hintText,
                icon: Icon(
                  icon,
                  color: Colors.grey,
                )),
            onChanged: onChanged,
          ),
        );
  }
}