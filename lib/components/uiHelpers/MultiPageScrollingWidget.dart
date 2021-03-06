import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/utilities/UiHelpers.dart';


class MultiPageScrollingWidget extends StatefulWidget
{
  late List<Widget> _screens;
  late List<BottomNavigationBarItem> _bottomNavigationBarItems;
  late final Color _navBarSelectedItemColor;
  late Color? _navBarUnselectedItemColor;
  late final double _marginAroundScreens;
  late final _showLogoutButton;

  MultiPageScrollingWidget({
    required List<Widget> screens,
    required List<BottomNavigationBarItem> bottomNavigationBarItems,
    required Color navBarSelectedItemColor,
    Color? navBarUnselectedItemColor,
    double marginAroundScreens = 20,
    bool showLogoutButton = true,
  })
  {
    this._screens = screens;
    this._bottomNavigationBarItems = bottomNavigationBarItems;
    this._navBarSelectedItemColor = navBarSelectedItemColor;
    this._navBarUnselectedItemColor = navBarUnselectedItemColor;
    this._marginAroundScreens = marginAroundScreens;
    this._showLogoutButton = showLogoutButton;
  }



  @override
  State<StatefulWidget> createState()
  {
    return MultiPageScrollingWidgetState(this._screens,
                                         this._bottomNavigationBarItems,
                                         this._navBarSelectedItemColor,
                                         this._navBarUnselectedItemColor,
                                         this._marginAroundScreens,
                                         this._showLogoutButton);
  }
}



class MultiPageScrollingWidgetState extends State
{
  // Variables
  late final PageController pageController;
  late List<Widget> screens = [];
  PageView? pageView;
  late int _index = 0;
  late List<BottomNavigationBarItem> _bottomNavigationBarItems;
  late final Color _navBarSelectedItemColor;
  late final Color? _navBarUnselectedItemColor;
  late final double _marginAroundScreens;
  late final _showLogoutButton;

  // Constructor
  MultiPageScrollingWidgetState(
    List<Widget> screens,
    List<BottomNavigationBarItem> bottomNavigationBarItems,
    Color navBarSelectedItemColor,
    Color? navBarUnselectedItemColor,
    double marginAroundScreens,
    this._showLogoutButton
  )
  {
    this.screens = screens;
    this._bottomNavigationBarItems = bottomNavigationBarItems;
    this._navBarSelectedItemColor = navBarSelectedItemColor;
    this._navBarUnselectedItemColor = navBarUnselectedItemColor;
    this._marginAroundScreens = marginAroundScreens;

    this.pageController = PageController(
      keepPage: true,
      initialPage: 0,
    );
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
      unselectedItemColor: _navBarUnselectedItemColor,
      onTap: (int index) => _onNavbarItemTapped(index),

      // Prevent bug that causes icons to turn white if there's > 3
      type: BottomNavigationBarType.fixed,
    );
  }



  @override
  Widget build(BuildContext context)
  {
    this.pageView = getPageView(pageController,
                                screens,
                                _onPageChanged);

    return Scaffold(
      appBar: StrydeAppBar(titleStr: "Stryde"),
      body: Container(
        margin: EdgeInsets.all(_marginAroundScreens),
        child: pageView,
      ),
      bottomNavigationBar: _getNavbar(),
    );
  }
}
