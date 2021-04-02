import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/nav/StrydeWorkoutAndSupertsetTabMenu.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/WorkoutListScreen.dart';
import 'SupersetListScreen.dart';


class WorkoutAndSupersetListScreen extends StatelessWidget
{
  List<Widget> _screens;

  WorkoutAndSupersetListScreen()
  {
    _screens = [
      WorkoutListScreen(),
      SupersetListScreen()
    ];
  }



  @override
  Widget build(BuildContext context)
  {
    return StrydeWorkoutAndSupertsetTabMenu(screens: _screens);
  }
}
