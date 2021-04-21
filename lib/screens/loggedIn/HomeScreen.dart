import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:Stryde/components/uiHelpers/MultiPageScrollingWidget.dart';
import 'package:Stryde/models/UserExperience.dart';
import 'package:Stryde/screens/loggedIn/userProfile/UserProfileScreen.dart';
import 'package:Stryde/screens/loggedIn/workoutList/WorkoutAndSupersetListScreen.dart';
import 'workoutSchedule/WorkoutScheduleScreen.dart';


class HomeScreen extends StatelessWidget
{
  List<Widget> _screens = [];
  Map<String, dynamic> _userInfo;

  HomeScreen(this._userInfo)
  {
    StrydeUserStorage.userExperience = new UserExperience(
      this._userInfo["id"], this._userInfo["username"],
      this._userInfo["password"], this._userInfo["goal"] ?? "",
      this._userInfo["experienceName"]
    );

    this._screens = [
      WorkoutScheduleScreen(),
      WorkoutAndSupersetListScreen(),
      //AllProgressGraphsScreen(),
      UserProfileScreen(),
    ];
  }



  List<BottomNavigationBarItem> _getNavbarItems()
  {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today_rounded),
        label: 'Schedule',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.fitness_center_rounded),
        label: 'Workouts',
      ),
      /*
      BottomNavigationBarItem(
        icon: Icon(Icons.stacked_line_chart_rounded),
        label: 'Progress',
      ),
      */
      BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        label: 'Profile',
      ),
    ];
  }



  @override
  Widget build(BuildContext context)
  {
    return MultiPageScrollingWidget(
      screens: _screens,
      bottomNavigationBarItems: _getNavbarItems(),
      navBarSelectedItemColor: StrydeColors.lightBlue,
      navBarUnselectedItemColor: StrydeColors.darkGray,
      marginAroundScreens: 0,
    );
  }
}