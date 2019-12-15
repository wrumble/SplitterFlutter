import 'package:flutter/material.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Screens/HomeScreen/HomeScreenViewModel.dart';
import 'package:splitter/Screens/LoginAndSignupScreen/LoginAndSignupScreenViewModel.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';
import 'package:splitter/Screens/LoginAndSignupScreen/LoginAndSignupScreen.dart';
import 'package:splitter/Screens/HomeScreen/HomeScreen.dart';

enum AuthenticationState {
  undetermined,
  notLoggedIn,
  loggedIn,
}

class RootPage extends StatefulWidget {
  RootPage({@required this.authenticationService, @required this.cloudStoreService});

  final AuthenticationServiceType authenticationService;
  final CloudStoreServiceType cloudStoreService;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthenticationState authStatus = AuthenticationState.undetermined;
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
          authStatus = AuthenticationState.notLoggedIn;
        }
      });
  }

  void login() async {
    String userId = await widget.authenticationService.currentUserId();
    User user = await widget.cloudStoreService.fetchUserWithId(userId);
    setState(() {
      _user = user;
      authStatus = AuthenticationState.loggedIn;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthenticationState.notLoggedIn;
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
      case AuthenticationState.undetermined:
        return buildWaitingScreen();
        break;
      case AuthenticationState.notLoggedIn:
        final viewModel = LoginAndSignupScreenViewModel(authenticationService: widget.authenticationService,
                                                        cloudStoreService: widget.cloudStoreService,
                                                        loginCallback: logoutCallback);
        return new LoginAndSignupScreen(viewModel: viewModel);
        break;
      case AuthenticationState.loggedIn:
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