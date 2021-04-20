import 'package:Stryde/components/strydeHelpers/widgets/tags/StrydeMultiTagDisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeExerciseAndSupersetTabMenu.dart';
import 'package:Stryde/screens/loggedIn/workoutList/AllExerciseListScreen.dart';
import 'AllSupersetListScreen.dart';


class AllExerciseAndSupersetListScreen extends StatelessWidget
{
  late List<Widget> _screens;
  late StrydeMultiTagDisplay _tagDisplay;

  AllExerciseAndSupersetListScreen()
  {
    _screens = [
      AllExerciseListScreen(),
      AllSupersetListScreen(),
    ];

    /*
    _tagDisplay = StrydeMultiTagDisplay(
      displayText: [],
      onDeleteTag: (int index, String displayStr) =>
          _onDeselectExerciseTag(index, displayStr),
    );
    */
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: StrydeAppBar(titleStr: "Select Exercise / Superset", context: context),
      //body: StrydeExerciseAndSupersetTabMenu(screens: _screens),
      body: Column(
        children: [
          Expanded(
            child: StrydeExerciseAndSupersetTabMenu(screens: _screens),
          ),
          /*
          Container(
            margin: EdgeInsets.only(bottom: 15),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelText(
                  "Selected Exercises",
                  labelTextSize: 14,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: _selectExercisesTagDisplay,
                ),
              ],
            ),
          ),
           */
        ],
      )
    );
    //return StrydeExerciseAndSupersetTabMenu(screens: _screens);
  }
}
