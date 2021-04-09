import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeWorkoutAndSupertsetTabMenu.dart';
import 'package:Stryde/screens/loggedIn/workoutList/UserWorkoutListScreen.dart';
import 'UserSupersetListScreen.dart';


class WorkoutAndSupersetListScreen extends StatelessWidget
{
  late final List<Widget> _screens;

  WorkoutAndSupersetListScreen()
  {
    _screens = [
      UserWorkoutListScreen(),
      UserSupersetListScreen()
    ];
  }



  @override
  Widget build(BuildContext context)
  {
    return StrydeWorkoutAndSupersetTabMenu(screens: _screens);
  }
}
