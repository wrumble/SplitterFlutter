import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';

abstract class LoginAndSignupScreenViewModelType {
  Stream<String> get errorText;
  Stream<bool> get isLoading;
  Stream<bool> get isLoginForm;

  void signIn(String email, String password);
  void signUp(User user, String password);
  void dispose();
}

class LoginAndSignupScreenViewModel implements LoginAndSignupScreenViewModelType {
  LoginAndSignupScreenViewModel({@required this.authenticationService,
                                 @required this.cloudStoreService, 
                                 @required this.loginCallback});
  
  final AuthenticationServiceType authenticationService;
  final CloudStoreServiceType cloudStoreService;
  final VoidCallback loginCallback;

  final errorController = StreamController<String>.broadcast();
  final isLoadingController = StreamController<bool>.broadcast();
  final isLoginController = StreamController<bool>.broadcast();

  @override
  Stream<String> get errorText => errorController.stream;
  @override
  Stream<bool> get isLoading => isLoadingController.stream;
  @override
  Stream<bool> get isLoginForm => isLoginController.stream;

  @override
  void signIn(String email, String password) async {
    _setStateBeforeCall(true);
    try {
      // authenticationService.signIn(email, password)
      // .asStream()
      // .asyncMap(cloudStoreService.fetchUserWithId)
      // .map((user){
      //   print('Signed in: ${user.id}');
      //   isLoadingController.add(false);
      // }).handleError((error) {
      //   _updateError(error.message);
      //   isLoadingController.add(false);
      // });
      String userId = await authenticationService.signIn(email, password);
      User user = await cloudStoreService.fetchUserWithId(userId)
        .whenComplete(loginCallback);
      print('Signed in: ${user.id}');
    } catch (error) {
      _updateError(error.message);
    }
    isLoadingController.add(false);
  }

  @override 
  void signUp(User user, String password) async {
    _setStateBeforeCall(false);
    try {
      String userId = await authenticationService.signUp(user.email, password);
      await cloudStoreService.createUser(user)
        .then(showHomeScreenIfValidUser);
      print('Signed up user: ${user.id}');
    } catch (error) {
        _updateError(error.message);
    }
    isLoadingController.add(false);
  }

  @override 
  void dispose() {
    isLoginController.close();
    isLoadingController.close();
    errorController.close();
  }

  void showHomeScreenIfValidUser(User user) {
    if (user != null) {
      loginCallback();
    }
  }

  void _updateError(String text) {
    errorController.add(text);
  }

  void _setStateBeforeCall(bool isLoginForm) {
    isLoginController.add(isLoginForm);
    isLoadingController.add(true);
    errorController.add("");
  }

  void validateAndSubmit(GlobalKey<FormState> formKey, String password, User user) {
    final form = formKey.currentState;
    if (form.validate()) {
          form.save();
      if (isLoginForm) {
        signIn(user.email, password);
      } else {
        signUp(user, password);
      }
    }
  }
}