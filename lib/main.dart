import 'package:flutter/material.dart';
import 'package:splitter/Screens/RootScreen/RootScreenViewModel.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';
import 'package:splitter/Screens/RootScreen/RootScreen.dart';

void main() {
  runApp(Splitter());
}

class Splitter extends StatefulWidget {

  @override
  SplitterState createState() => SplitterState();
}

class SplitterState extends State<Splitter> {
  RootScreenViewModelType rootViewModel;
  @override
  void initState() {
        rootViewModel = RootScreenViewModel(authenticationService: AuthenticationService(),
                                              cloudStoreService: CloudStoreService());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
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