import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FormSettings.dart';
import 'InputFormElement.dart';
import 'LabelTextElement.dart';



// Number w/ Options - No Label
class NumberWithOptionsInputElement extends InputFormElement
{
  NumberWithOptionsInputElement(String placeholderText,
                                {inputTextSize = FormSettings.defaultInputTextSize,
                                 placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super(placeholderText, TextInputType.numberWithOptions(decimal: true),
              inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  NumberWithOptionsInputElement.controller(String placeholderText,
                                           TextEditingController textEditingController,
                                           {inputTextSize = FormSettings.defaultInputTextSize,
                                            placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super.controller(placeholderText, TextInputType.numberWithOptions(decimal: true),
                         textEditingController,
                         inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  NumberWithOptionsInputElement.value(String placeholderText, String value,
                                      {inputTextSize = FormSettings.defaultInputTextSize,
                                       placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super.value(placeholderText, TextInputType.numberWithOptions(decimal: true), value,
                    inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
}



// Number w/ Options - Label
class LabeledNumberWithOptionsInputElement extends StatelessWidget
{
  String _labelText;
  String _placeholderText;
  late String _value;
  late NumberWithOptionsInputElement inputElement;
  int labelTextSize;

  LabeledNumberWithOptionsInputElement(this._labelText, this._placeholderText,
                                       {inputTextSize = FormSettings.defaultInputTextSize,
                                        placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                                        this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = NumberWithOptionsInputElement.value(this._placeholderText, this._value,
                                                       inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
  }

  LabeledNumberWithOptionsInputElement.value(this._labelText, this._placeholderText,
                                             this._value,
                                             {inputTextSize = FormSettings.defaultInputTextSize,
                                              placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                                              this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    inputElement = NumberWithOptionsInputElement.value(this._placeholderText, this._value,
                                                       inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
  }



  String getInputText()
  {
    return this.inputElement.getInputText();
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
