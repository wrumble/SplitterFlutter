import 'package:flutter/material.dart';
import './Services/FirebaseAuthentication.dart';
import './Screens/RootScreen.dart';

void main() {
  runApp(new Spltter());
}

class Spltter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth()));
  }
}