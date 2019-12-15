import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splitter/Models/User.dart';

abstract class CloudStoreServiceType
 {
  Future<User> fetchUserWithId(String id);
  Future<User> createUser(User user);
}

class CloudStoreService implements CloudStoreServiceType
{
    final Firestore _cloudStore = Firestore.instance;

  Future<User> fetchUserWithId(String userId) async {
    try {
      DocumentSnapshot userDocument = await _cloudStore.document("Users/$userId").get();
      return User.fromSnapshot(userDocument);
    } catch (error) {
      print("Error fetching user: $error");
      return null;
    }
  }

    Future<User> createUser(User user) async {
    try {
      await _cloudStore.collection("Users")
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
}