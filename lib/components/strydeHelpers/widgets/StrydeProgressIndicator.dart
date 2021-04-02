import 'package:flutter/material.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';


class StrydeProgressIndicator extends CircularProgressIndicator
{
  StrydeProgressIndicator({
    Color backgroundColor = StrydeColors.lightGray,
    Color foregroundColor = StrydeColors.lightBlue,
  }) :
      super(
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
      );
}