import 'package:flutter/material.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Services/AuthenticationService.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, 
              @required  this.authenticationService,
              @required this.user,
              @required this.logoutCallback})
      : super(key: key);

  final AuthenticationServiceType authenticationService;
  final VoidCallback logoutCallback;
  final User user;

  @override
  State<StatefulWidget> createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Logged In as ${widget.user.firstName} ${widget.user.lastName}'),
          actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: _signOut)
          ],
        )
    );
  }

  _signOut() async {
    try {
      await widget.authenticationService.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
}