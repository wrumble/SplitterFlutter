import 'package:flutter/material.dart';
import 'package:splitter/Models/User.dart';
import 'HomeScreenViewModel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, 
              @required this.viewModel,
              @required this.user})
      : super(key: key);

  final HomeScreenViewModelType viewModel;
  final User user;

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Logged In as ${widget.user.firstName} ${widget.user.lastName}'),
          actions: <Widget>[
          FlatButton(
              child: Text('Logout',
                  style: TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: widget.viewModel.signOut)
          ],
        )
    );
  }
}