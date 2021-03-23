import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:workout_buddy/components/uiHelpers/MultiPageScrollingWidget.dart';
import 'package:workout_buddy/screens/loggedIn/AllProgressGraphsScreen.dart';
import 'package:workout_buddy/screens/loggedIn/UserProfileScreen.dart';
import 'WorkoutListScreen.dart';
import 'WorkoutScheduleScreen.dart';


class HomeScreen extends StatefulWidget
{
  Map<String, dynamic> _userInfo;

  HomeScreen(this._userInfo);

  @override
  State<StatefulWidget> createState()
  {
    return HomeScreenState(this._userInfo);
  }
}



class HomeScreenState extends State
{
  // Variables
  List<Widget> _screens = [];
  Map<String, dynamic> _userInfo;

  HomeScreenState(this._userInfo)
  {
    this._screens = [
      WorkoutScheduleScreen(),
      WorkoutListScreen(),
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