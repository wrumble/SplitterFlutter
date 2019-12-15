import 'package:flutter/material.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Screens/RootScreen.dart';
import 'package:splitter/Services/CloudStoreService.dart';

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
        home: new RootPage(authenticationService: new AuthenticationService(),
                           cloudStoreService: new CloudStoreService()),
    );
  }
}