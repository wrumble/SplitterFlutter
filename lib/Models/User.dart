class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  User(this.id, this.firstName, this.lastName, this.email);

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

  User.fromJson(Map<String, dynamic> json) :
    this(json["id"],
         json["firstName"],
         json["lastName"],
         json["email"]);
}