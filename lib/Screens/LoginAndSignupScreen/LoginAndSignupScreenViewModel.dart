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
  User user;
  String password;
  BehaviorSubject<FormType> get formType;
  BehaviorSubject<String> get errorMessage;
  BehaviorSubject<bool> get isLoading;

  void onSubmit();
  void toggleView();
  bool isLoginForm();
  void setFirstName(String firstName);
  void setLastName(String lastName);
  void setEmail(String email);
  void setPassword(String password);
  String toggleButtonText();
  String submitButtonText();
}

class LoginAndSignupScreenViewModel implements LoginAndSignupScreenViewModelType {
  LoginAndSignupScreenViewModel({@required this.authenticationService,
                                 @required this.cloudStoreService}) {
                                   setupStreams();
                                 }
  
  final AuthenticationServiceType authenticationService;
  final CloudStoreServiceType cloudStoreService;
  
  User user = User(id: null, firstName: null, lastName: null, email: null);
  String password;

  BehaviorSubject<FormType> formType;
  BehaviorSubject<String> errorMessage;
  BehaviorSubject<bool> isLoading;

  void setupStreams() {
    formType = BehaviorSubject<FormType>.seeded(FormType.login);
    errorMessage = BehaviorSubject<String>.seeded(null);
    isLoading = BehaviorSubject<bool>.seeded(false);
  }
  void login() async {
    try {
      String userId = await authenticationService.signIn(user.email, password);
      user = await cloudStoreService.fetchUserWithId(userId);
    } catch (error) {
      errorMessage.add(error.message);
    }
  }

  void signUp() async {
    try {
      user.id = await authenticationService.signUp(user.email, password);
      user = await cloudStoreService.createUser(user);
    } catch (error) {
        errorMessage.add(error.message);
    }
  }

  void onSubmit() async {
    if (fieldsAreValid()) {
      errorMessage.add(null);
      isLoading.add(true);
      isLoginForm() ? await login() : await signUp();
      isLoading.add(false);
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
    return emailIsValid() && passWordIsValid();
  }

  bool emailIsValid() {
    return user.email == null ? setErrorAndFail("Email can't be empty") : true;
  }

  bool passWordIsValid() {
    if (password != null) {
      return password.length < 6 ? setErrorAndFail("Password must contain 6 characters") : true;
    } else {
      return setErrorAndFail("Password can't be empty");
    }
  }

  bool namesAreValid() {
    if (user.firstName == null) {
      return setErrorAndFail("First name can't be empty");
    } else if (user.lastName == null) {
      return setErrorAndFail("Last name can't be empty");
    } else {
      return true;
    }
  }

  bool setErrorAndFail(String error) {
    errorMessage.add(error);
    return false;
  }

  void toggleView() {
    errorMessage.add(null);
    isLoginForm() ? formType.add(FormType.signUp) : formType.add(FormType.login);
  }

  bool isLoginForm() {
    return formType.value == FormType.login;
  }

  void setFirstName(String firstName) {
    user.firstName = firstName.trim();
  }

  void setLastName(String lastName) {
    user.lastName = lastName.trim();
  }

  void setEmail(String email) {
    user.email = email.trim();
  }

  void setPassword(String password) {
    password = password.trim();
  }

  String toggleButtonText() {
    return isLoginForm() ? 'Create an account' : 'Have an account? Sign in';
  }

  String submitButtonText() {
    return isLoginForm() ? 'Login' : 'Create account';
  }
}