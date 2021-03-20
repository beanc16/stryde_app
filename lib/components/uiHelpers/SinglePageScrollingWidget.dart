import "package:flutter/material.dart";



class SinglePageScrollingWidget extends StatefulWidget
{
  // Variable
  final Widget _child;
  final bool shouldKeepAlive;

  // Constructor
  SinglePageScrollingWidget(this._child, {this.shouldKeepAlive: true});



  @override
  State<StatefulWidget> createState()
  {
    return SinglePageScrollingWidgetState(this._child, this.shouldKeepAlive);
  }
}



class SinglePageScrollingWidgetState extends
            State<SinglePageScrollingWidget> with
    AutomaticKeepAliveClientMixin<SinglePageScrollingWidget>
{
  // Variable
  final Widget _child;
  final bool _shouldKeepAlive;

  // Constructor
  SinglePageScrollingWidgetState(this._child, this._shouldKeepAlive);



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

            child: this._child,
          )
        );
      }
    );
  }

  @override
  bool get wantKeepAlive => this._shouldKeepAlive;
}
