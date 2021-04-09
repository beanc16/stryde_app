import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/uiHelpers/MultiPageScrollingWidget.dart';
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
      screens: _screens,
      bottomNavigationBarItems: _getNavbarItems(),
      navBarSelectedItemColor: StrydeColors.lightBlue,
      navBarUnselectedItemColor: StrydeColors.darkGray,
    );
  }
}