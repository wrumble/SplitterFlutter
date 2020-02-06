import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:splitter/Models/User.dart';

abstract class CloudStoreServiceType {
  Firestore cloudStore;

  Future<User> fetchUserWithId(String id);
  Future<User> createUser(User user);
}

class CloudStoreService implements CloudStoreServiceType {
   CloudStoreService({@required this.cloudStore});
   
  Firestore cloudStore;

  Future<User> fetchUserWithId(String userId) async {
    try {
      DocumentSnapshot userDocument = await cloudStore.document("Users/$userId").get();
      return User.fromJson(userDocument.data);
    } catch (error) {
      print("Error fetching user: $error");
      return null;
    }
  }

    Future<User> createUser(User user) async {
    try {
      await cloudStore.collection("Users")
        .document(user.id)
        .setData({
          'id': user.id,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'email': user.email
        });
        return user;
    } catch (error) {
      print("Error creating user: $error");
      return null;
    }
  }
}