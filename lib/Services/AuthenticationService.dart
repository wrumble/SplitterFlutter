import 'dart:async';

import 'package:flutter/foundation.dart';
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
  AuthenticationService({@required this.firebaseAuthentication}) {
    listenToAuthStateChange();
  }

  final FirebaseAuth firebaseAuthentication;
  BehaviorSubject<AuthenticationState> authenticationState;


  void listenToAuthStateChange() {
    authenticationState = BehaviorSubject<AuthenticationState>.seeded(AuthenticationState.loading);
    firebaseAuthentication.onAuthStateChanged.listen(setAuthenticationState);
  }

  void setAuthenticationState(FirebaseUser firebaseUser) {
    if (firebaseUser != null) {
      authenticationState.add(AuthenticationState.loggedIn);
    } else {
      authenticationState.add(AuthenticationState.loggedOut);
    }
  }

  Future<String> signIn(String email, String password) async {
    AuthResult result = await firebaseAuthentication.signInWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await firebaseAuthentication.createUserWithEmailAndPassword(email: email, password: password);
    return result.user.uid; 
  }

  Future<String> currentUserId() async {
    FirebaseUser firebaseUser = await firebaseAuthentication.currentUser();
    if (firebaseUser != null) {
      return firebaseUser.uid;
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    return firebaseAuthentication.signOut();
  }
}