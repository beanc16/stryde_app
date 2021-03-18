import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:workout_buddy/components/nav/MyAppBar.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';


class StartupScreen extends StatelessWidget
{
  // Variables
  PageController pageController;

  // Constructor
  StartupScreen()
  {
    pageController = PageController(
      keepPage: true,
    );
  }



  @override
  Widget build(BuildContext context)
  {
    List<Widget> screens = [
      LoginScreen(),
      RegisterScreen(),
    ];

    PageView pageView = getPageView(pageController, screens);

    return Scaffold(
      appBar: MyAppBar.getAppBar("Stryde"),
      body: Container(
        margin: getDefaultMargin(),
        child: pageView,
      ),
    );
  }
}
