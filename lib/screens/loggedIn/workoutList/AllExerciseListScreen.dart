import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:workout_buddy/components/nav/MyAppBar.dart';
import 'package:workout_buddy/components/uiHelpers/SearchableListView.dart';

class AllExerciseListScreen extends StatelessWidget
{
  List<String> _listTileDisplayText = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: MyAppBar.getAppBar("Add Exercise"),
      body: SearchableListView(
        // Text
        _listTileDisplayText,
        textColor: StrydeColors.darkGray,
        textSize: 20,
        searchBarPlaceholderText: "Search exercises...",

        // Border
        borderColor: StrydeColors.darkBlue,
        borderWidth: 2,

        // Miscellaneous
        spaceBetweenTiles: 15,
        //onTapListTile: (context, index) => _callback(context, index),
      )
    );
  }
}