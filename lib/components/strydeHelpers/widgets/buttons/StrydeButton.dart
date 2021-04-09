import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/utilities/UiHelpers.dart';



class StrydeButton extends StatelessWidget
{
  late final String _displayText;
  late final double _textSize;
  late final Function()? _onTap;

  StrydeButton({required String displayText,
                required double textSize,
                required Function()? onTap})
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