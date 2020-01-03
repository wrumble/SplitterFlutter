import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';

enum FormType {
  login,
  signUp
}

abstract class LoginAndSignupScreenViewModelType {  
  String email;
  String password;
  String firstName;
  String lastName;
  BehaviorSubject<FormType> get formType;
  BehaviorSubject<String> get errorMessage;
  BehaviorSubject<bool> get isLoading;

  void onSubmit();
  void toggleView();
  bool isLoginForm();
}

class LoginAndSignupScreenViewModel implements LoginAndSignupScreenViewModelType {
  LoginAndSignupScreenViewModel({@required this.authenticationService,
                                 @required this.cloudStoreService}) {
                                   setupStreams();
                                 }
  
  final AuthenticationServiceType authenticationService;
  final CloudStoreServiceType cloudStoreService;
  
  String email;
  String password;
  String firstName;
  String lastName;

  BehaviorSubject<FormType> formType;
  BehaviorSubject<String> errorMessage;
  BehaviorSubject<bool> isLoading;

  void setupStreams() {
    formType = BehaviorSubject<FormType>.seeded(FormType.login);
    errorMessage = BehaviorSubject<String>.seeded(null);
    isLoading = BehaviorSubject<bool>.seeded(false);
  }
  void signIn() async {
    try {
      String userId = await authenticationService.signIn(email, password);
      User user = await cloudStoreService.fetchUserWithId(userId);
      print('Signed in: ${user.firstName} ${user.lastName}');
    } catch (error) {
      print(error);
    }
  }

  void signUp() async {
    try {
      String userId = await authenticationService.signUp(email, password);
      User user = User(id: userId, firstName: firstName, lastName: lastName, email: email);
      await cloudStoreService.createUser(user);
      print('Signed up user: ${user.id}');
    } catch (error) {
        print(error);
    }
  }

  void onSubmit() async {
    if (fieldsAreValid()) {
      errorMessage.add(null);
      isLoading.add(true);
      isLoginForm() ? await signIn() : await signUp();
      isLoading.add(false);
    } else {
      errorMessage.add("Invalid Field Entry");
    }
  }

  bool fieldsAreValid() {
    if (isLoginForm()) {
      return emailAndPasswordAreValid();
    } else {
      return emailAndPasswordAreValid() && namesAreValid();
    }
  }

  bool emailAndPasswordAreValid() {
    return email != null && passWordIsValid();
  }

  bool passWordIsValid() {
    if (password != null) {
      return password.length >= 6;
    } else {
      return false;
    }
  }

  bool namesAreValid() {
    return firstName.isNotEmpty && lastName.isNotEmpty;
  }

  void toggleView() {
    errorMessage.add(null);
    isLoginForm() ? formType.add(FormType.signUp) : formType.add(FormType.login);
  }

  bool isLoginForm() {
    return formType.value == FormType.login;
  }
}