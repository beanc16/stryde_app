import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MyAppBar
{
  static AppBar myAppBarNoButton;
  static Text titleText;



  static AppBar getAppBar(String title)
  {
    if (myAppBarNoButton == null)
    {
      titleText = Text(title);

      myAppBarNoButton = AppBar(
        //leading: getLogo(8),
        title: getLogoTitleRow(),
        //title: getLogo(8),
        backgroundColor: StrydeColors.lightBlue,
      );
    }

    return myAppBarNoButton;
  }



  static Widget getLogoTitleRow()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getLogo(8),
        titleText
      ],
    );
  }

  static Widget getLogo(double padding)
  {
    Widget svg = SvgPicture.asset(
      "images/strydeLogoClean.svg",
      semanticsLabel: "Stryde Logo",

      fit: BoxFit.contain,
      height: 40,

      placeholderBuilder: (BuildContext context) =>
          _getLogoPadding(context, padding),
    );

    return Padding(
      child: svg,
      padding: EdgeInsets.only(
        top: padding,
        bottom: padding,
        right: padding,
      ),
    );
  }

  static Widget _getLogoPadding(BuildContext context, double padding)
  {
    return Padding(
      padding: EdgeInsets.only(
        left: padding,
        top: padding,
        bottom: padding,
      ),
    );
  }



  static void updateTitle(String newTitle)
  {
    if (myAppBarNoButton == null)
    {
      titleText = Text(newTitle);
    }

    // Else, set appbar's state
  }
}
