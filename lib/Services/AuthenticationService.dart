import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationServiceType
 {
  Stream<FirebaseUser> get firebaseUser;
  
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> currentUserId();
  Future<bool> isEmailVerified();
  Future<void> sendEmailVerification();
  Future<void> signOut();
}

class AuthenticationService implements AuthenticationServiceType
 {
  final FirebaseAuth _authentication = FirebaseAuth.instance;

  Stream<FirebaseUser> get firebaseUser {
    _subjectCounter = new BehaviorSubject<int>.seeded(this.initialCount);
    return _authentication.onAuthStateChanged;
  }

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _authentication.signInWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  Future<String> signUp(String email, String password) async {
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
    await user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _authentication.currentUser();
    return user.isEmailVerified;
  }
}