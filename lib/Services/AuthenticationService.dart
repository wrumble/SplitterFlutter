import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationServiceType
 {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password, String firstName, String lastName);
  Future<String> currentUserId();
  Future<bool> isEmailVerified();
  Future<void> sendEmailVerification();
  Future<void> signOut();
}

class AuthenticationService implements AuthenticationServiceType
 {
  final FirebaseAuth _authentication = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _authentication.signInWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  Future<String> signUp(String email, String password, String firstName, String lastName) async {
    AuthResult result = await _authentication.createUserWithEmailAndPassword(email: email, password: password);
    return result.user.uid; 
  }

  Future<String> currentUserId() async {
    FirebaseUser firebaseUser = await _authentication.currentUser();
    return firebaseUser != null ? firebaseUser.uid : null;
  }

  Future<void> signOut() async {
    return _authentication.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _authentication.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _authentication.currentUser();
    return user.isEmailVerified;
  }
}