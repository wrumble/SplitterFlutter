import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:splitter/Screens/RootScreen/RootScreenViewModel.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';
import 'package:splitter/Screens/RootScreen/RootScreen.dart';

import 'Models/ThemeData.dart';

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
    return PlatformApp(
              title: 'Splitter',
              debugShowCheckedModeBanner: false,
              android: (_) => androidAppThemeData,
              ios: (_) => iosAppThemeData,
              home: RootScreen(viewModel: rootViewModel),
    );
  }
}