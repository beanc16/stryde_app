import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/nav/StrydeExerciseAndSupersetTabMenu.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/nav/StrydeWorkoutAndSupertsetTabMenu.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/AllExerciseListScreen.dart';

import 'AllSupersetListScreen.dart';


class AllExerciseAndSupersetListScreen extends StatelessWidget
{
  List<Widget> _screens;

  AllExerciseAndSupersetListScreen()
  {
    _screens = [
      AllExerciseListScreen(),
      AllSupersetListScreen(),
    ];
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: StrydeAppBar(titleStr: "Select Exercise / Superset"),
      body: StrydeExerciseAndSupersetTabMenu(screens: _screens),
    );
    //return StrydeExerciseAndSupersetTabMenu(screens: _screens);
  }
}
