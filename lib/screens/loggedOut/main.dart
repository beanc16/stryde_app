import 'dart:core';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/nav/MyAppBar.dart';
import 'package:workout_buddy/screens/loggedIn/CreateViewSupersetScreen.dart';
import 'package:workout_buddy/screens/loggedIn/CreateViewWorkoutScreen.dart';
import 'package:workout_buddy/screens/loggedIn/EditWorkoutScreen.dart';
import 'package:workout_buddy/screens/loggedIn/HomeScreen.dart';

import 'StartupScreen.dart';


void main()
{
  runApp(MyApp());
}



class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: "Stryde",
      //home: StartupScreen(),
      home: HomeScreen(),
      //home: CreateViewWorkoutScreen(),
      //home: CreateViewSupersetScreen(),
    );
  }
}
