import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FormSettings.dart';



// Label for labeled elements
class LabelTextElement extends StatelessWidget
{
  String _labelText;
  int labelTextSize;

  LabelTextElement(this._labelText,
                   {this.labelTextSize = FormSettings.defaultLabelTextSize});



  @override
  Widget build(BuildContext context)
  {
    return Text(
      this._labelText,
      style: TextStyle(
        fontSize: this.labelTextSize.toDouble()
      ),
    );
  }
}
