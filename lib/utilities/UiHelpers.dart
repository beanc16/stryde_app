import "package:flutter/material.dart";



// Progress Indicator
Center getCircularProgressIndicatorCentered()
{
  return Center(
    child: CircularProgressIndicator(),
  );
}



// Raised Button
RaisedButton getRaisedButton(String displayText, double fontSize,
                             Function() callback)
{
  return RaisedButton(
    child: Text(
      displayText,
      style: TextStyle(
          fontSize: fontSize
      ),
    ),

    onPressed: callback,
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
PageView getPageView(PageController pageController, List<Widget> screens)
{
  return PageView.builder(
    controller: pageController,

    itemCount: screens.length,
    itemBuilder: (BuildContext context, int index)
    {
      return screens[index];
    },
  );
}
