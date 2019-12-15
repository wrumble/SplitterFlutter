import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String firstName;
  String lastName;

  User(this.id, this.firstName, this.lastName);

  toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
    };
  }

  User.fromSnapshot(DocumentSnapshot snapshot) :
    this(snapshot.data["id"],
         snapshot.data["firstName"],
         snapshot.data["lastName"]);
}