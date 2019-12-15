import 'package:flutter/material.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Screens/LoginSignupScreen.dart';
import 'package:splitter/Screens/HomeScreen.dart';
import 'package:splitter/Services/CloudStoreService.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({@required this.authenticationService, @required this.cloudStoreService});

  final AuthenticationServiceType authenticationService;
  final CloudStoreServiceType cloudStoreService;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
        return new LoginSignupPage(
          authenticationService: widget.authenticationService,
          cloudStoreService: widget.cloudStoreService,
          loginCallback: login,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_user != null) {
          return new HomeScreen(
            user: _user,
            authenticationService: widget.authenticationService,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}