import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FormSettings.dart';
import 'InputFormElement.dart';
import 'LabelTextElement.dart';



// Number - No Label
class NumberInputElement extends InputFormElement
{
  NumberInputElement(String placeholderText,
                     {inputTextSize = FormSettings.defaultInputTextSize,
                      placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super(placeholderText, TextInputType.number,
              inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  NumberInputElement.controller(String placeholderText,
                                TextEditingController textEditingController,
                                {inputTextSize = FormSettings.defaultInputTextSize,
                                 placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super.controller(placeholderText, TextInputType.number, textEditingController,
                         inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  NumberInputElement.value(String placeholderText, String value,
                           {inputTextSize = FormSettings.defaultInputTextSize,
                            placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super.value(placeholderText, TextInputType.number, value,
                    inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
}



// Number - Label
class LabeledNumberInputElement extends StatelessWidget
{
  String _labelText;
  String _placeholderText;
  String _value;
  NumberInputElement inputElement;
  int labelTextSize;

  LabeledNumberInputElement(this._labelText, this._placeholderText,
                            {inputTextSize = FormSettings.defaultInputTextSize,
                             placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                             this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    this._value = "";
    this.inputElement = NumberInputElement.value(this._placeholderText, this._value,
                                                 inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
  }

  LabeledNumberInputElement.value(this._labelText, this._placeholderText, this._value,
                                  {inputTextSize = FormSettings.defaultInputTextSize,
                                   placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                                   this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    this.inputElement = NumberInputElement.value(this._placeholderText, this._value,
                                                 inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
  }



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

        this.inputElement,
      ],
    );
  }
}
