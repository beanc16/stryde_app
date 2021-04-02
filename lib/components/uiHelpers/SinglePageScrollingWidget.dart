import "package:flutter/material.dart";



class SinglePageScrollingWidget extends StatefulWidget
{
  // Variable
  Widget _child;
  bool _shouldKeepAlive;
  double _marginAroundScreens;

  // Constructor
  SinglePageScrollingWidget({@required Widget child,
                             shouldKeepAlive: true,
                             double marginAroundScreens = 0})
  {
    this._child = child;
    this._shouldKeepAlive = shouldKeepAlive;
    this._marginAroundScreens = marginAroundScreens;
  }



  @override
  State<StatefulWidget> createState()
  {
    return SinglePageScrollingWidgetState(this._child,
                                          this._shouldKeepAlive,
                                          this._marginAroundScreens);
  }
}



class SinglePageScrollingWidgetState extends
            State<SinglePageScrollingWidget> with
    AutomaticKeepAliveClientMixin<SinglePageScrollingWidget>
{
  // Variable
  final Widget _child;
  final bool _shouldKeepAlive;
  final double _marginAroundScreens;

  // Constructor
  SinglePageScrollingWidgetState(this._child, this._shouldKeepAlive,
                                 this._marginAroundScreens);



  @override
  Widget build(BuildContext context)
  {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints)
      {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),

            child: Container(
              margin: EdgeInsets.all(_marginAroundScreens),
              child: _child,
            ),
          )
        );
      }
    );
  }

  @override
  bool get wantKeepAlive => this._shouldKeepAlive;
}
