import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:workout_buddy/components/strydeHelpers/StrydeUserStorage.dart';
import 'package:workout_buddy/components/uiHelpers/MultiPageScrollingWidget.dart';
import 'package:workout_buddy/models/UserExperience.dart';
import 'package:workout_buddy/screens/loggedIn/progressGraphs/AllProgressGraphsScreen.dart';
import 'package:workout_buddy/screens/loggedIn/userProfile/UserProfileScreen.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/WorkoutAndSupersetListScreen.dart';
import 'workoutList/WorkoutListScreen.dart';
import 'workoutSchedule/WorkoutScheduleScreen.dart';


class HomeScreen extends StatefulWidget
{
  Map<String, dynamic> _userInfo;

  HomeScreen(this._userInfo);

  @override
  State<StatefulWidget> createState()
  {
    StrydeUserStorage.userExperience = new UserExperience(
      this._userInfo["id"], this._userInfo["username"],
      this._userInfo["password"], this._userInfo["goal"],
      this._userInfo["experienceName"]
    );

    return HomeScreenState();
  }
}



class HomeScreenState extends State
{
  // Variables
  List<Widget> _screens = [];

  HomeScreenState()
  {
    this._screens = [
      WorkoutScheduleScreen(),
      WorkoutAndSupersetListScreen(),
      AllProgressGraphsScreen(),
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
        icon: Icon(FlutterIcons.ios_fitness_ion),
        label: 'Workouts',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.stacked_line_chart_rounded),
        label: 'Progress',
      ),
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
      _screens, _getNavbarItems(), StrydeColors.lightBlue,
      navBarUnselectedItemColor: StrydeColors.darkGray,
    );
  }
}