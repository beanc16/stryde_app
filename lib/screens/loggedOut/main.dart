import 'dart:core';
import 'package:flutter/material.dart';
import 'StartupScreen.dart';


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
