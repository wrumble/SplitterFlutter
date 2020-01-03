import 'package:flutter/foundation.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;

  User({@required this.id, 
        @required this.firstName, 
        @required this.lastName, 
        @required this.email});

  isValid() {
    return id != null &&
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