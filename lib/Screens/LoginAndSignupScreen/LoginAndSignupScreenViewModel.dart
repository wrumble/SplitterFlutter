import 'package:flutter/foundation.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';

abstract class LoginAndSignupScreenViewModelType {  
  signIn(String email, String password);
  signUp(String email, String password, String firstName, String lastName);
}

class LoginAndSignupScreenViewModel implements LoginAndSignupScreenViewModelType {
  LoginAndSignupScreenViewModel({@required this.authenticationService,
                                 @required this.cloudStoreService, 
                                 @required this.loginCallback});
  
  final AuthenticationServiceType authenticationService;
  final CloudStoreServiceType cloudStoreService;
  final VoidCallback loginCallback;

  @override
  signIn(String email, String password) async {
    try {
      String userId = await authenticationService.signIn(email, password);
      User user = await cloudStoreService.fetchUserWithId(userId)
        .whenComplete(loginCallback);
      print('Signed in: ${user.firstName} ${user.lastName}');
    } catch (error) {
      print(error);
    }
  }

  @override 
  signUp(String email, String password, String firstName, String lastName) async {
    try {
      String userId = await authenticationService.signUp(email, password);
      User user = new User(userId, firstName, lastName);
      await cloudStoreService.createUser(user)
        .then(showHomeScreenIfValidUser);
      print('Signed up user: ${user.id}');
    } catch (error) {
        print(error);
    }
  }

  showHomeScreenIfValidUser(User user) {
    if (user != null) {
      loginCallback();
    }
  }
}