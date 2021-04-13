import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/utilities/UiHelpers.dart';



class StrydeButtonWithIcon extends StatelessWidget
{
  late final String _displayText;
  late final double _textSize;
  late final Function(BuildContext) _onTap;
  late final IconData _iconData;

  StrydeButtonWithIcon({
    required String displayText,
    required double textSize,
    required Function(BuildContext) onTap,
    required IconData iconData,
  })
  {
    this._displayText = displayText;
    this._textSize = textSize;
    this._onTap = onTap;
    this._iconData = iconData;
  }



  @override
  Widget build(BuildContext context)
  {
    return RaisedButton(
      color: StrydeColors.purple,
      onPressed: () => _onTap(context),
      child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  _iconData,
                  color: Colors.white,
                ),
              ),
              Text(
                _displayText,
                style: TextStyle(
                  fontSize: _textSize,
                  color: Colors.white,
                ),
              ),
            ],
          )
      ),
    );
  }
}