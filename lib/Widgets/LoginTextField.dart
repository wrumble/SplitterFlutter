import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField(this.icon,
                 this.hintText, 
                 this.onChanged,
                 {this.obscureText = false,
                  this.keyboardType = TextInputType.text});

  final IconData icon;
  final String hintText;
  final Function(String) onChanged;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
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