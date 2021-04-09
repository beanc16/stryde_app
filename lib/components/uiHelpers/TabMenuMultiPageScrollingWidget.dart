import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TabMenuMultiPageScrollingWidget extends StatefulWidget
{
  late List<Widget> _screens;
  late List<String> _tabsDisplayText;
  late final Color _tabBarSelectedItemColor;
  late final Color _tabBarUnselectedItemColor;
  late final Color _tabBarBackgroundColor;

  TabMenuMultiPageScrollingWidget({
    required List<Widget> screens,
    required List<String> tabsDisplayText,
    Color tabBarSelectedItemColor = Colors.blue,
    Color tabBarUnselectedItemColor = Colors.black,
    Color tabBarBackgroundColor = Colors.white,
  })
  {
    this._screens = screens;
    this._tabsDisplayText = tabsDisplayText;
    this._tabBarSelectedItemColor = tabBarSelectedItemColor;
    this._tabBarUnselectedItemColor = tabBarUnselectedItemColor;
    this._tabBarBackgroundColor = tabBarBackgroundColor;
  }



  @override
  State<StatefulWidget> createState()
  {
    return TabMenuMultiPageScrollingWidgetState(
      this._screens,
      this._tabsDisplayText,
      this._tabBarSelectedItemColor,
      this._tabBarUnselectedItemColor,
      this._tabBarBackgroundColor
    );
  }
}



class TabMenuMultiPageScrollingWidgetState extends State<TabMenuMultiPageScrollingWidget>
{
  List<Widget> _screens = [];
  List<String> _tabsDisplayText = [];
  late Color _tabBarSelectedItemColor;
  late Color _tabBarUnselectedItemColor;
  late Color _tabBarBackgroundColor;

  TabMenuMultiPageScrollingWidgetState(
    List<Widget> screens,
    List<String> tabsDisplayText,
    Color tabBarSelectedItemColor,
    Color tabBarUnselectedItemColor,
    Color tabBarBackgroundColor
  )
  {
    this._screens = screens;
    this._tabsDisplayText = tabsDisplayText;

    this._tabBarSelectedItemColor = tabBarSelectedItemColor;
    this._tabBarUnselectedItemColor = tabBarUnselectedItemColor;
    this._tabBarBackgroundColor = tabBarBackgroundColor;
  }



  DefaultTabController _getTabController()
  {
    return DefaultTabController(
      length: _screens.length,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getTabBar(),
          _getScreensToDisplay(),
        ],
      )
    );
  }

  Container _getTabBar()
  {
    return Container(
      // Tab Menu
      child: TabBar(
        labelColor: _tabBarSelectedItemColor,  // Selected Text Color
        unselectedLabelColor: _tabBarUnselectedItemColor, // Unselected
        tabs: _getTabDisplayTexts(),
      ),

        // Shadow
        decoration: BoxDecoration(
          color: _tabBarBackgroundColor,       // Background Color
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              //spreadRadius: 5,
              blurRadius: 2,
              offset: Offset(0, 0)
            )
          ]
        ),
    );
  }

  List<Tab> _getTabDisplayTexts()
  {
    List<Tab> results = [];

    for (int i = 0; i < _tabsDisplayText.length; i++)
    {
      Tab tab = Tab(
        child: Text(
          _tabsDisplayText[i],
          style: TextStyle(
            fontSize: 20,
          )
        ),
      );
      results.add(tab);
    }

    return results;
  }

  Widget _getScreensToDisplay()
  {
    return Expanded(
      child: TabBarView(
        children: _screens,
      ),
    );
  }



  @override
  Widget build(BuildContext context)
  {
    return Container(
      child: _getTabController(),
    );
  }
}