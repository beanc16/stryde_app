import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';


class StrydeSuccessText extends Text
{
  StrydeSuccessText({
    @required String displayText
  }) :
      super(
        displayText,
          style: TextStyle(
            color: StrydeColors.darkGreenSuccess,
            fontSize: 16,
          )
      );
}