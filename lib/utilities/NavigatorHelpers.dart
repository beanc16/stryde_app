import "package:flutter/material.dart";



class NavigateTo
{
  // Go to a screen w/ a back button
  static void screen(BuildContext context,
                     Function() route)
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)
        {
          return route();
        }
      )
    );
  }

  // Go to a screen w/ a back button & run callback
  static void screenThen(BuildContext context,
                         Function() route,
                         Function() callback)
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)
        {
          return route();
        }
      )
    )
    .then((value) => callback());
  }



  // Go to a screen w/o a back button
  static void screenWithoutBack(BuildContext context,
                                Function() route)
  {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context)
        {
          return route();
        }
      )
    );
  }

  // Go to a screen w/o a back button & run callback
  static void screenWithoutBackThen(BuildContext context,
                                    Function() route,
                                    Function() callback)
  {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context)
        {
          return route();
        }
      )
    )
    .then((value) => callback());
  }



  static void previousScreen(BuildContext context)
  {
    Navigator.pop(context);
  }

  static void previousScreenThen(BuildContext context,
                                 Function() callback)
  {
    Navigator.maybePop(context)
             .then( (value) => callback() );
  }



  // Pop the given number of screens, then go to the given route
  static void screenWithoutBackUntil(BuildContext context,
                                     Function() route,
                                     int numOfScreensToGoBack)
  {
    int numOfRoutes = 0;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context)
        {
          return route();
        }
      ),
      ((Route<dynamic> route)
      {
        if (route is MaterialPageRoute<dynamic>)
        {
          if (numOfRoutes > numOfScreensToGoBack)
          {
            return true;
          }
        }

        return false;
      })
    );
  }
}
