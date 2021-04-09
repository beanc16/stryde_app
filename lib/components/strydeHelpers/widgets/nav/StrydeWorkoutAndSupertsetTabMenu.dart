import 'package:flutter/cupertino.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/uiHelpers/TabMenuMultiPageScrollingWidget.dart';


class StrydeWorkoutAndSupersetTabMenu extends TabMenuMultiPageScrollingWidget
{
  StrydeWorkoutAndSupersetTabMenu({
    required List<Widget> screens
  }) :
      super(
        screens: screens,
        tabsDisplayText: ["Workouts", "Supersets"],
        tabBarSelectedItemColor: StrydeColors.lightBlue,
        tabBarUnselectedItemColor: StrydeColors.darkGray,
      );
}