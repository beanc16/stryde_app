import 'package:flutter/cupertino.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';


class StrydeErrorText extends Text
{
  StrydeErrorText({
    required String displayText
  }) :
      super(
        displayText,
          style: TextStyle(
            color: StrydeColors.darkRedError,
            fontSize: 16,
          )
      );
}