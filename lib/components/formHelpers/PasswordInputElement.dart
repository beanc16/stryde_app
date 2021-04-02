import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FormSettings.dart';
import 'LabelTextElement.dart';
import 'TextElements.dart';



// Password - No Label
class PasswordInputElement extends TextInputElement
{
  PasswordInputElement(String placeholderText,
                       {inputTextSize = FormSettings.defaultInputTextSize,
                        placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super.password(placeholderText, inputTextSize: inputTextSize,
                       placeholderTextSize: placeholderTextSize);
}



// Password - Label
class LabeledPasswordInputElement extends StatelessWidget
{
  String _labelText;
  String _placeholderText;
  String _value;
  TextInputElement inputElement;
  int labelTextSize;


  LabeledPasswordInputElement(this._labelText, this._placeholderText,
                              {inputTextSize = FormSettings.defaultInputTextSize,
                               placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                               this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = TextInputElement.password(this._placeholderText,
                                             inputTextSize: inputTextSize,
                                             placeholderTextSize: placeholderTextSize);
  }

  /*
  LabeledPasswordInputElement.value(this._labelText, this._placeholderText, this._value)
  {
    inputElement = PasswordInputElement.value(this._placeholderText, this._value);
    inputElement = PasswordInputElement(this._placeholderText);
  }
  */



  void setInputText(String str)
  {
    this.inputElement.setInputText(str);
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        LabelTextElement(
          this._labelText,
          labelTextSize: this.labelTextSize
        ),

        this.inputElement
      ],
    );
  }
}
