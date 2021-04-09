import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FormSettings.dart';




// Label for labeled elements
class LabelText extends Text
{
  String _labelText;
  late int labelTextSize;

  LabelText(this._labelText,
                   {int labelTextSize = FormSettings.defaultLabelTextSize}) :
    super(
      _labelText,
      style: TextStyle(
        fontSize: labelTextSize.toDouble()
      ),
    );
}
