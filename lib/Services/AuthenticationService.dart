import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:splitter/Models/AuthenticationState.dart';

abstract class AuthenticationServiceType {
  BehaviorSubject<AuthenticationState> get authenticationState;

  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> currentUserId();
  Future<void> signOut();
  void listenToAuthStateChange(); 
}

class AuthenticationService implements AuthenticationServiceType {

  final FirebaseAuth authentication = FirebaseAuth.instance;
  BehaviorSubject<AuthenticationState> authenticationState;

  AuthenticationService() {
    listenToAuthStateChange();
  }

  void listenToAuthStateChange() {
    authenticationState = BehaviorSubject<AuthenticationState>.seeded(AuthenticationState.loading);
    authentication.onAuthStateChanged.listen(setAuthenticationState);
  }

  void setAuthenticationState(FirebaseUser firebaseUser) {
    if (firebaseUser != null) {
      authenticationState.add(AuthenticationState.loggedIn);
    } else {
      authenticationState.add(AuthenticationState.loggedOut);
    }
  }

  Future<String> signIn(String email, String password) async {
    AuthResult result = await authentication.signInWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await authentication.createUserWithEmailAndPassword(email: email, password: password);
    return result.user.uid; 
  }

  Future<String> currentUserId() async {
    FirebaseUser firebaseUser = await authentication.currentUser();
    if (firebaseUser != null) {
      return firebaseUser.uid;
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    return authentication.signOut();
  }
}