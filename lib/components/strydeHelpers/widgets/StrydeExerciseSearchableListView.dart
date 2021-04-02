import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/listViews/searchableListView/SearchableListView.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';


class StrydeExerciseSearchableListView extends SearchableListView
{
  StrydeExerciseSearchableListView({
    @required List<String> listTileDisplayText,
    @required Function(BuildContext, int) onTapListTile
  }) :
      super(
        // Text
        listTileDisplayText,
        textColor: StrydeColors.darkGray,
        textSize: 20,
        searchBarPlaceholderText: "Search exercises...",

        // Border
        borderColor: StrydeColors.darkBlue,
        borderWidth: 2,

        // Miscellaneous
        spaceBetweenTiles: 15,
        onTapListTile: (BuildContext context, int index) =>
          onTapListTile(context, index),
        onTapColor: StrydeColors.lightBlue,
      );
}