import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:workout_buddy/utilities/NavigatorHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';


class MyAppBar
{
  static AppBar myAppBarNoButton;
  static Text titleText;



  static AppBar getAppBar(String title)
  {
    if (myAppBarNoButton == null)
    {
      titleText = Text(title);

      myAppBarNoButton = AppBar(
        title: titleText,
        backgroundColor: StrydeColors.lightBlue,
      );
    }

    return myAppBarNoButton;
  }



  static void updateTitle(String newTitle)
  {
    if (myAppBarNoButton == null)
    {
      titleText = Text(newTitle);
    }
  }
}
