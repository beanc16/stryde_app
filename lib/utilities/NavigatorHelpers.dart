import "package:flutter/material.dart";



// Go to a screen w/ a back button
void navigateToScreen(context, Function() route)
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

// Go to a screen w/ a back button
void navigateToScreenThen(context, Function() route, Function() callback)
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
void navigateToScreenWithoutBack(context, Function() route)
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

// Go to a screen w/o a back button
void navigateToScreenWithoutBackThen(context, Function() route, Function() callback)
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



// Go back to the previous screen
void navigateBack(context)
{
  Navigator.pop(context);
}

void navigateBackThen(context, Function() callback)
{
  Navigator.maybePop(context)
           .then( (value) => callback() );
}



//
void navigateToScreenWithoutBackUntil(context, Function() route, int numOfScreensToGoBack)
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