import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';

enum AuthenticationState {
  loggedIn,
  loggeOut,
  loading
}

abstract class RootScreenViewModelType {
  Stream<Future<User>> get user;
}

class RootScreenViewModel with ChangeNotifier implements RootScreenViewModelType {
    RootScreenViewModel({@required this.authenticationService, 
                         @required this.cloudStoreService});

  final AuthenticationServiceType authenticationService;
  final CloudStoreServiceType cloudStoreService;  

  Stream<Future<User>> get user {
    return authenticationService.firebaseUser
      .map(setStateForUser)
      .map(convert);
  }

  setStateForUser(FirebaseUser user) {
    if (user.uid != null) {
      _state = AuthenticationState.loggedIn;
    } else {
      _state = AuthenticationState.loggeOut;
    }
  }

  AuthenticationState _state = AuthenticationState.loading;

  AuthenticationState currentState() {
    return _state;
  }

}