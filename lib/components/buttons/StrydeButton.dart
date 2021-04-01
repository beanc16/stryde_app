import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/colors/StrydeColors.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';



class StrydeButton extends StatelessWidget
{
  String _displayText;
  double _textSize;
  Function() _onTap;

  StrydeButton({@required String displayText,
                @required double textSize,
                @required Function() onTap})
  {
    this._displayText = displayText;
    this._textSize = textSize;
    this._onTap = onTap;
  }



  @override
  Widget build(BuildContext context)
  {
    return getRaisedButton(
      _displayText, _textSize, _onTap,
      buttonColor: StrydeColors.purple,
      textColor: Colors.white
    );
  }
}