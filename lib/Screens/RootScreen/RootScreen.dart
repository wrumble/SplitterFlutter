import 'package:flutter/material.dart';

import 'package:splitter/Models/AuthenticationState.dart';
import 'package:splitter/Screens/HomeScreen/HomeScreenViewModel.dart';
import 'package:splitter/Screens/LoginAndSignupScreen/LoginAndSignupScreen.dart';
import 'package:splitter/Screens/LoginAndSignupScreen/LoginAndSignupScreenViewModel.dart';
import 'package:splitter/Screens/RootScreen/RootScreenViewModel.dart';
import 'package:splitter/Screens/HomeScreen/HomeScreen.dart';

class RootScreen extends StatelessWidget {

  RootScreen({@required this.viewModel});

  final RootScreenViewModelType viewModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthenticationState>(
      initialData: AuthenticationState.loading,
      stream: viewModel.authenticationState,
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case AuthenticationState.loggedOut:
            return getLoginAndSignupScreen();
          case AuthenticationState.loggedIn:
              return homeScreen();
          default:
            return waitingScreen();
        }
    });
  }

  LoginAndSignupScreen getLoginAndSignupScreen() {
    final loginAndSignupScreenViewModel = LoginAndSignupScreenViewModel(authenticationService: viewModel.authenticationService,
                                                            cloudStoreService: viewModel.cloudStoreService);
    return LoginAndSignupScreen(viewModel: loginAndSignupScreenViewModel);
  }

  HomeScreen homeScreen() {
    final homeScreenViewModel = HomeScreenViewModel(authenticationService: viewModel.authenticationService,
                                                    cloudStoreService: viewModel.cloudStoreService);
     return HomeScreen(user: viewModel.userSubject.value,
                       viewModel: homeScreenViewModel);
  }

  Widget waitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}