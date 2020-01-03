import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Widgets/NullWidget.dart';
import 'HomeScreenViewModel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({@required this.viewModel, @required this.user});

  final HomeScreenViewModelType viewModel;
  final User user;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
          appBar: PlatformAppBar(
              title: PlatformText('Splitter',
              style: TextStyle(color: Colors.white, 
                                       fontSize: 26
                             )),
              ios: (_) => CupertinoNavigationBarData(
                  transitionBetweenRoutes: false,
                  leading: PlatformButton(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: viewModel.signOut,
                  ),
                ),
              android: (_) => MaterialAppBarData(centerTitle: true,
                                  leading: PlatformButton(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(Icons.arrow_back, color: Colors.white),
                                  onPressed: viewModel.signOut,
                                  androidFlat: (_) => MaterialFlatButtonData(color: Colors.transparent),
                                )
                              )
              ),
              body: NullWidget(),
            );
  }
}