class User {
  String id;
  String firstName;
  String lastName;

  User(this.id, this.firstName, this.lastName);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
    };
  }

  User.fromJson(Map<String, dynamic> json) :
    this(json["id"],
         json["firstName"],
         json["lastName"]);
}