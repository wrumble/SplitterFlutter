import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splitter/Models/User.dart';

abstract class BaseAuth {
  Future<User> signIn(String email, String password);

  Future<User> signUp(String email, String password, String firstName, String lastName);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firebaseStore = Firestore.instance;


  Future<User> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return await fetchUserWithId(result.user.uid);
  }

  Future<User> signUp(String email, String password, String firstName, String lastName) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    User user = User(result.user.uid, firstName, lastName);
    await createUser(user);
    return user;
  }

  Future<User> getCurrentUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();

    if (firebaseUser != null) {
      return await fetchUserWithId(firebaseUser.uid);
    } else {
      return null;
    }
  }

  Future<User> fetchUserWithId(String id) async {
    try {
      DocumentSnapshot userDocument = await _firebaseStore.document("Users/$id").get();
      return User.fromSnapshot(userDocument);;
    } catch (error) {
      print("Error fetching user: $error");
      return null;
    }
  }

  Future<User> createUser(User user) async {
    try {
      await _firebaseStore.collection("Users")
        .document(user.id)
        .setData({
          'id': user.id,
          'firstName': user.firstName,
          'lastName': user.lastName
        });
        return user;
    } catch (error) {
      print("Error creating user: $error");
      return null;
    }

  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}