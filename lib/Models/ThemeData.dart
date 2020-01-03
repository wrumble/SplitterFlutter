import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

final androidAppThemeData = MaterialAppData(theme: ThemeData(primarySwatch: Colors.blue,
                                                             scaffoldBackgroundColor: Colors.white,
                                                             accentColor: Colors.blue,
                                                             appBarTheme: AppBarTheme(color: Colors.blue.shade600),
                                                             primaryColor: Colors.blue,
                                                             secondaryHeaderColor: Colors.blue,
                                                             canvasColor: Colors.blue,
                                                             backgroundColor: Colors.red,
                                                             textTheme: TextTheme().copyWith(body1: TextTheme().body1)
                                                    )
                             );

final iosAppThemeData = CupertinoAppData(theme: CupertinoThemeData(primaryColor: Colors.blue,
                                                                   barBackgroundColor: Colors.blue,
                                                                   scaffoldBackgroundColor: Colors.white
                                                )
                        );