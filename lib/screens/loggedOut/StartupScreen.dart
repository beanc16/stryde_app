import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:workout_buddy/components/uiHelpers/MultiPageScrollingWidget.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';


class StartupScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return StartupScreenState();
  }
}



class StartupScreenState extends State
{
  // Variables
  List<Widget> _screens = [];

  // Constructor
  StartupScreenState()
  {
    this._screens = [
      LoginScreen(),
      RegisterScreen(),
    ];
  }



  List<BottomNavigationBarItem> _getNavbarItems()
  {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.login_rounded),
        label: 'Login',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.app_registration),
        label: 'Register',
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