import 'package:flutter/material.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';
import 'package:splitter/Screens/RootScreen/RootScreen.dart';

void main() {
  runApp(new Spltter());
}

class Spltter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootScreen(authenticationService: new AuthenticationService(),
                             cloudStoreService: new CloudStoreService()),
    );
  }
}