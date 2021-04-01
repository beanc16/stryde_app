import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/colors/StrydeColors.dart';
import 'package:workout_buddy/components/uiHelpers/TabMenuMultiPageScrollingWidget.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/WorkoutListScreen.dart';
import 'SupersetListScreen.dart';

class WorkoutAndSupersetListScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return WorkoutAndSupersetListState();
  }
}



class WorkoutAndSupersetListState extends State<WorkoutAndSupersetListScreen>
{
  List<Widget> _screens;

  @override
  void initState()
  {
    _screens = [
      WorkoutListScreen(),
      SupersetListScreen()
    ];
  }



  @override
  Widget build(BuildContext context)
  {
    return TabMenuMultiPageScrollingWidget(
      _screens,
      ["Workouts", "Supersets"],    // Display text for each tab
      tabBarSelectedItemColor: StrydeColors.lightBlue,
      tabBarUnselectedItemColor: StrydeColors.darkGray,
    );
  }
}