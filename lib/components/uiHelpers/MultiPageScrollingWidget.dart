import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/nav/MyAppBar.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';


class MultiPageScrollingWidget extends StatefulWidget
{
  List<Widget> _screens;
  List<BottomNavigationBarItem> _bottomNavigationBarItems;
  Color _navBarSelectedItemColor;

  MultiPageScrollingWidget(
    List<Widget> screens,
    List<BottomNavigationBarItem> bottomNavigationBarItems,
    Color navBarSelectedItemColor
  )
  {
    this._screens = screens;
    this._bottomNavigationBarItems = bottomNavigationBarItems;
    this._navBarSelectedItemColor = navBarSelectedItemColor;
  }



  @override
  State<StatefulWidget> createState()
  {
    return MultiPageScrollingWidgetState(this._screens,
                                         this._bottomNavigationBarItems,
                                         this._navBarSelectedItemColor);
  }
}



class MultiPageScrollingWidgetState extends State
{
  // Variables
  PageController pageController;
  List<Widget> screens = [];
  PageView pageView;
  int _index = 0;
  List<BottomNavigationBarItem> _bottomNavigationBarItems;
  Color _navBarSelectedItemColor;

  // Constructor
  MultiPageScrollingWidgetState(
    List<Widget> screens,
    List<BottomNavigationBarItem> bottomNavigationBarItems,
    Color navBarSelectedItemColor
  )
  {
    this.screens = screens;
    this._bottomNavigationBarItems = bottomNavigationBarItems;
    this._navBarSelectedItemColor = navBarSelectedItemColor;

    this.pageController = PageController(
      keepPage: true,
      initialPage: 0,
    );
    this.pageView = getPageView(pageController, screens, _onPageChanged);
  }



  void _onPageChanged(int index)
  {
    setState(()
    {
      _index = index;
    });
  }

  void _onNavbarItemTapped(int index)
  {
    setState(()
    {
      _index = index;

      this.pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  Widget _getNavbar()
  {
    return BottomNavigationBar(
      items: _bottomNavigationBarItems,

      currentIndex: this._index,
      selectedItemColor: _navBarSelectedItemColor,
      onTap: (int index) => _onNavbarItemTapped(index),
    );
  }



  @override
  Widget build(BuildContext context)
  {
    this.pageView = getPageView(pageController,
                                screens,
                                _onPageChanged);

    return Scaffold(
      appBar: MyAppBar.getAppBar("Stryde"),
      body: Container(
        margin: getDefaultMargin(),
        child: pageView,
        ),
      bottomNavigationBar: _getNavbar(),
    );
  }
}
