import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:workout_buddy/components/uiHelpers/TabMenuMultiPageScrollingWidget.dart';


class StrydeExerciseAndSupersetTabMenu extends TabMenuMultiPageScrollingWidget
{
  StrydeExerciseAndSupersetTabMenu({
    @required List<Widget> screens
  }) :
      super(
        screens: screens,
        tabsDisplayText: ["Exercises", "Supersets"],
        tabBarSelectedItemColor: StrydeColors.lightBlue,
        tabBarUnselectedItemColor: StrydeColors.darkGray,
      );
}