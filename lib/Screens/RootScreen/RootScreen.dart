import 'package:flutter/material.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Screens/HomeScreen/HomeScreenViewModel.dart';
import 'package:splitter/Screens/LoginAndSignupScreen/LoginAndSignupScreen.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';
import 'package:splitter/Screens/HomeScreen/HomeScreen.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootScreen extends StatefulWidget {
  RootScreen({@required this.authenticationService, @required this.cloudStoreService});

  final AuthenticationServiceType authenticationService;
  final CloudStoreServiceType cloudStoreService;

  @override
  State<StatefulWidget> createState() => new _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  User _user;

  @override
  void initState() {
    super.initState();
    setInitialState();
  }

  void setInitialState() async {
    String userId = await widget.authenticationService.currentUserId();
      setState(() {
        if (userId != null) {
          login();
        } else {
          authStatus = AuthStatus.NOT_LOGGED_IN;
        }
      });
  }

  void login() async {
    String userId = await widget.authenticationService.currentUserId();
    User user = await widget.cloudStoreService.fetchUserWithId(userId);
    setState(() {
      _user = user;
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _user = null;
    });
  }

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
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginAndSignupScreen(
          authenticationService: widget.authenticationService,
          cloudStoreService: widget.cloudStoreService,
          loginCallback: login,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_user != null) {
          final viewModel = HomeScreenViewModel(authenticationService: widget.authenticationService,
                                                logoutCallback: logoutCallback);
          return new HomeScreen(
            user: _user,
            viewModel: viewModel,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}