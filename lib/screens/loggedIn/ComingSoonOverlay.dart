import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ComingSoonOverlay extends ModalRoute<void>
{
  @override
  Duration get transitionDuration => Duration(microseconds: 1);

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => Colors.black.withOpacity(0.5);

  @override
  // Whether you can dismiss this route by tapping the modal barrier
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => "Coming Soon...";

  @override
  bool get maintainState => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
                   Animation<double> secondaryAnimation)
  {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context)
  {
    return Center(
      child: Text(
        "Coming Soon...",
        style: TextStyle(
          color: Colors.white,
          fontSize: 48,
        ),
      ),
    );
  }
}
