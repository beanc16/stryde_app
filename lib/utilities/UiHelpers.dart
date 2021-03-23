import "package:flutter/material.dart";
import 'package:workout_buddy/components/misc/StrydeColors.dart';



// Progress Indicator
Center getCircularProgressIndicatorCentered()
{
  return Center(
    child: CircularProgressIndicator(),
  );
}



// Raised Button
RaisedButton getRaisedButton(String displayText, double fontSize,
                             Function() callback, {Color textColor,
                                                   Color buttonColor})
{
  return RaisedButton(
    child: Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor
        ),
      )
    ),

    onPressed: callback,
    color: buttonColor,
  );
}



// Padding
Padding getPadding(double amount)
{
  return Padding(
    padding: EdgeInsets.all(amount)
  );
}

Padding getDefaultPadding()
{
  return getPadding(15);
}



// Margin
EdgeInsets getDefaultMargin()
{
  return const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20);
}



// PageView (lets you swipe between screens easily)
PageView getPageView(PageController pageController,
                     List<Widget> screens,
                     Function(int) onPageChanged)
{
  return PageView.builder(
    controller: pageController,
    onPageChanged: (int index) => onPageChanged(index),

    itemCount: screens.length,
    itemBuilder: (BuildContext context, int index)
    {
      return screens[index];
    },
  );
}
