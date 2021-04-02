import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:workout_buddy/components/uiHelpers/TabMenuMultiPageScrollingWidget.dart';


class StrydeWorkoutAndSupertsetTabMenu extends TabMenuMultiPageScrollingWidget
{
  StrydeWorkoutAndSupertsetTabMenu({
    @required List<Widget> screens
  }) :
      super(
        screens: screens,
        tabsDisplayText: ["Workouts", "Supersets"],
        tabBarSelectedItemColor: StrydeColors.lightBlue,
        tabBarUnselectedItemColor: StrydeColors.darkGray,
      );
}