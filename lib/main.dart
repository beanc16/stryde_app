import 'dart:core';
import 'package:flutter/material.dart';
import 'screens/loggedOut/StartupScreen.dart';


void main()
{
  runApp(Stryde());
}



class Stryde extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: "Stryde",
      home: StartupScreen(),
    );
  }
}
