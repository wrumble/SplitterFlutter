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
  User user;
  String userId;

  void getCurrentAuthenticationState();
}

class RootScreenViewModel implements RootScreenViewModelType {
    RootScreenViewModel({@required this.authenticationService, 
                         @required this.cloudStoreService}) {
                           getCurrentAuthenticationState();
                         }

  AuthenticationServiceType authenticationService;
  CloudStoreServiceType cloudStoreService;
  
  BehaviorSubject<AuthenticationState> authenticationState = BehaviorSubject<AuthenticationState>();
  BehaviorSubject<User> userSubject = BehaviorSubject<User>();
  User user;
  String userId;

  void getCurrentAuthenticationState() async {
    listenToAuthenticationState();
    listenToUserState();
    try {
      userId = await authenticationService.currentUserId();
      if (userId != null) {
        setLoggedIn();
      } else {
        setLoggedOut();
      }
    } catch (error) {
      onError(error);
    }
  }

  void listenToAuthenticationState() {
    authenticationService.authenticationState.stream.listen((authState) {
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
    userSubject.stream.listen((user) {
      if (user.isValid()) {
        this.user = user;
        authenticationState.add(AuthenticationState.loggedIn);
      }
    });
  }

  void setLoggedIn() async {
    try {
      userSubject.add(await cloudStoreService.fetchUserWithId(userId));
    } catch (error) {
      onError(error);
    }
  }

  void setLoggedOut() {
      authenticationState.add(AuthenticationState.loggedOut);
  }

  void onError(error) {
    print("SPLITTER ERROR: Login Error at RootScreenViewModel: $error");
    setLoggedOut();
  }
}