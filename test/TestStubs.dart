import 'package:splitter/Models/User.dart';

extension TestUser on User {
    static User stub([String id = "mockId", 
                      String firstName = "mockFirstName",
                      String lastName = "mockLastName",
                      String email = "mockEmail"]) {
      return User(id: id,
                  firstName: firstName, 
                  lastName: lastName, 
                  email: email);
    }
}