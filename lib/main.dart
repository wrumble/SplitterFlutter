import 'package:flutter/material.dart';
import 'package:splitter/Screens/RootScreen/RootScreenViewModel.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';
import 'package:splitter/Screens/RootScreen/RootScreen.dart';

void main() {
  runApp(Spltter());
}

class Spltter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationService = AuthenticationService();
    final cloudStoreService = CloudStoreService();
    final rootViewModel = RootScreenViewModel(authenticationService: authenticationService,
                                              cloudStoreService: cloudStoreService);
    return MaterialApp(
              title: 'Splitter',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: RootScreen(viewModel: rootViewModel),
            );
  }
}