import 'package:flutter/foundation.dart';

import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';

abstract class HomeScreenViewModelType {
  void signOut();
}

class HomeScreenViewModel implements HomeScreenViewModelType {
  HomeScreenViewModel({@required this.authenticationService,
                       @required this.cloudStoreService});

  final AuthenticationServiceType authenticationService;
  final CloudStoreServiceType cloudStoreService;

  void signOut() async {
    try {
      await authenticationService.signOut();
    } catch (error) {
      print(error);
    }
  }
}