import "package:flutter/material.dart";



class SinglePageScrollingWidget extends StatelessWidget
{
  // Variable
  final Widget _child;

  // Constructor
  SinglePageScrollingWidget(this._child);



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
}
