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

  static Future<dynamic> screenReturnsData(BuildContext context,
                                           Function() route) async
  {
    return await Navigator.push(
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
    Navigator.of(context).pop(true);
  }

  static void previousScreenWithData(BuildContext context,
                                     dynamic data)
  {
    Navigator.pop(context, data);
  }

  static void previousScreenThen(BuildContext context,
                                 Function() callback)
  {
    Navigator.maybePop(context)
             .then( (value) => callback() );
  }



  // Pop the given number of screens, then go to the given route
  static void screenAfterPopping(BuildContext context,
                                 Function() route,
                                 int numOfScreensToPop)
  {
    int numOfRoutes = 0;

    // Pop the given number of screens
    Navigator.popUntil(
      context,
      ((Route<dynamic> route)
      {
        if (route is MaterialPageRoute<dynamic>)
        {
          if (numOfRoutes >= numOfScreensToPop)
          {
            return true;
          }

          numOfRoutes++;
        }

        return false;
      })
    );

    // Push the given screen
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
}
