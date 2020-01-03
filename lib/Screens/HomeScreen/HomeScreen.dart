import 'package:flutter/material.dart';
import 'package:splitter/Models/User.dart';
import 'HomeScreenViewModel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({@required this.viewModel, @required this.user});

  final HomeScreenViewModelType viewModel;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Splitter'),
          actions: <Widget>[
          FlatButton(
              child: Text('Logout',
                  style: TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: viewModel.signOut)
          ],
        )
    );
  }
}