import 'package:flutter/material.dart';

import 'package:splitter/Models/AuthenticationState.dart';
import 'package:splitter/Screens/HomeScreen/HomeScreenViewModel.dart';
import 'package:splitter/Screens/LoginAndSignupScreen/LoginAndSignupScreen.dart';
import 'package:splitter/Screens/LoginAndSignupScreen/LoginAndSignupScreenViewModel.dart';
import 'package:splitter/Screens/RootScreen/RootScreenViewModel.dart';
import 'package:splitter/Screens/HomeScreen/HomeScreen.dart';

class RootScreen extends StatefulWidget {
  RootScreen({@required this.viewModel});

  final RootScreenViewModelType viewModel;

  @override
  State<StatefulWidget> createState() => RootScreenState();
}

class RootScreenState extends State<RootScreen> {

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthenticationState>(
      initialData: AuthenticationState.loading,
      stream: widget.viewModel.authenticationState.stream,
      builder: (context, snapshot) {
        print(snapshot.data);
        switch (snapshot.data) {
          case AuthenticationState.loading:
            return buildWaitingScreen();
            break;
          case AuthenticationState.loggedOut:
            final viewModel = LoginAndSignupScreenViewModel(authenticationService: widget.viewModel.authenticationService,
                                                            cloudStoreService: widget.viewModel.cloudStoreService);
            return LoginAndSignupScreen(viewModel: viewModel);
            break;
          case AuthenticationState.loggedIn:
              final viewModel = HomeScreenViewModel(authenticationService: widget.viewModel.authenticationService,
                                                    cloudStoreService: widget.viewModel.cloudStoreService);
              return HomeScreen(
                user: widget.viewModel.user,
                viewModel: viewModel,
              );
            break;
          default:
            return buildWaitingScreen();
        }
    });
  }


  // @override
  // Widget build(BuildContext context) {
  //   switch (widget.viewModel.authenticationState) {
  //     case AuthenticationState.undetermined:
  //       return buildWaitingScreen();
  //       break;
  //     case AuthenticationState.loggedOut:
  //       final viewModel = LoginAndSignupScreenViewModel(authenticationService: widget.viewModel.authenticationService,
  //                         cloudStoreService: widget.viewModel.cloudStoreService,
  //                         loginCallback: loginCallBack);
  //       return LoginAndSignupScreen(viewModel: viewModel);
  //       break;
  //     case AuthenticationState.loggedIn:
  //       if (_user != null) {
  //         final viewModel = HomeScreenViewModel(authenticationService: widget.viewModel.authenticationService,
  //                                               cloudStoreService: widget.viewModel.cloudStoreService);
  //         return HomeScreen(
  //           user: _user,
  //           viewModel: viewModel,
  //         );
  //       } else {
  //         return buildWaitingScreen();
  //       }
  //       break;
  //     default:
  //       return buildWaitingScreen();
  //   }
  // }
}