import 'package:flutter/foundation.dart';
import 'package:splitter/Services/AuthenticationService.dart';

abstract class HomeScreenViewModelType {  
  void signOut();
}

class HomeScreenViewModel implements HomeScreenViewModelType {
  HomeScreenViewModel({@required this.authenticationService,
                       @required this.logoutCallback});

  final AuthenticationServiceType authenticationService;
  final VoidCallback logoutCallback;

  @override 
  void signOut() async {
    try {
      await authenticationService.signOut()
        .whenComplete(logoutCallback);
    } catch (error) {
      print(error);
    }
  }
}