import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  User({@required this.id, 
        @required this.firstName, 
        @required this.lastName, 
        @required this.email});

  isValid() {
    return this != null &&
            id != null &&
            firstName != null &&
            lastName != null &&
            email != null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(id: json["id"],
                firstName: json["firstName"],
                lastName: json["lastName"],
                email: json["email"]);
  }
}