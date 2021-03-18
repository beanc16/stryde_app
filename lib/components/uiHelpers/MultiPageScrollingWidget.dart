import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MultiPageScrollingWidget extends StatelessWidget
{
  // Variables
  String appBarTitle;
  List<Widget> screens;
  PageController pageController;
  EdgeInsets margins;

  // Constructor
  MultiPageScrollingWidget(List<Widget> screens,
                           {String appBarTitle = "",
                            double leftMargin = 20,
                            double topMargin = 20,
                            double rightMargin = 20,
                            double bottomMargin = 20,})
  {
    this.appBarTitle = appBarTitle;
    this.screens = screens;
    this.pageController = PageController(
      keepPage: true,
    );
    this.margins = EdgeInsets.only(left: leftMargin,
                                   top: topMargin,
                                   right: rightMargin,
                                   bottom: bottomMargin);
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: getAppBar(appBarTitle, Colors.blue),
      body: Container(
        margin: margins,
        child: getPageView(pageController, screens),
      ),
    );
  }
}



AppBar getAppBar(String titleStr, MaterialColor materialColor)
{
  return AppBar(
    title: Text(titleStr),
    backgroundColor: materialColor,
  );
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
