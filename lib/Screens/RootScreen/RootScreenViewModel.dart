import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:splitter/Models/AuthenticationState.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';

abstract class RootScreenViewModelType {
  AuthenticationServiceType authenticationService;
  CloudStoreServiceType cloudStoreService;
  BehaviorSubject<AuthenticationState> authenticationState;
  BehaviorSubject<User> userSubject;
}

class RootScreenViewModel implements RootScreenViewModelType {
    RootScreenViewModel({@required this.authenticationService, 
                         @required this.cloudStoreService}) {
                               listenToAuthenticationState();
                               listenToUserState();
                         }

  AuthenticationServiceType authenticationService;
  CloudStoreServiceType cloudStoreService;
  
  BehaviorSubject<AuthenticationState> authenticationState = BehaviorSubject<AuthenticationState>();
  BehaviorSubject<User> userSubject = BehaviorSubject<User>();

  Future<void> listenToAuthenticationState() async {
    authenticationService.authenticationState.listen((authState) {
      switch (authState) {
        case AuthenticationState.loggedIn:
          setLoggedIn();
          break;
        case AuthenticationState.loggedOut:
          setLoggedOut();
          break;
        case AuthenticationState.loading:
          authenticationState.add(AuthenticationState.loading);
          break;
      }
    });
  }

  void listenToUserState() {
    userSubject.listen((user) {
      if (user != null && user.isValid()) {
        authenticationState.add(AuthenticationState.loggedIn);
      }
    });
  }

  void setLoggedIn() async {
    try {
      String userId = await authenticationService.currentUserId();
      User user = await cloudStoreService.fetchUserWithId(userId);
      userSubject.add(user);
    } catch (error) {
      onError(error);
    }
  }

  void setLoggedOut() {
      authenticationState.add(AuthenticationState.loggedOut);
  }

  void onError(error) {
    setLoggedOut();
  }
}