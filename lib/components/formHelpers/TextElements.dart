import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FormSettings.dart';
import 'InputFormElement.dart';
import 'LabelTextElement.dart';



// Text - No Label
class TextInputElement extends InputFormElement
{
  TextInputElement(String placeholderText,
                   {inputTextSize = FormSettings.defaultInputTextSize,
                    placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super(placeholderText, TextInputType.text,
              inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  TextInputElement.controller(String placeholderText, TextEditingController textEditingController,
                              {inputTextSize = FormSettings.defaultInputTextSize,
                               placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super.controller(placeholderText, TextInputType.text, textEditingController,
                         inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  TextInputElement.value(String placeholderText, String value,
                         {inputTextSize = FormSettings.defaultInputTextSize,
                          placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super.value(placeholderText, TextInputType.text, value,
                    inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  TextInputElement.password(String placeholderText,
                            {inputTextSize = FormSettings.defaultInputTextSize,
                             placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super.password(placeholderText, TextInputType.text,
                       inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  TextInputElement.textArea(String placeholderText,
                            {inputTextSize = FormSettings.defaultInputTextSize,
                             placeholderTextSize = FormSettings.defaultPlaceholderTextSize}) :
        super.textArea(placeholderText,
                       inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
}



// Text - Label
class LabeledTextInputElement extends StatelessWidget
{
  String _labelText;
  String _placeholderText;
  String _value;
  TextInputElement inputElement;
  int labelTextSize;


  LabeledTextInputElement(this._labelText, this._placeholderText,
                          {inputTextSize = FormSettings.defaultInputTextSize,
                           placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                           this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = TextInputElement.value(this._placeholderText, this._value,
                                          placeholderTextSize: placeholderTextSize,
                                          inputTextSize: inputTextSize);
  }

  LabeledTextInputElement.value(this._labelText, this._placeholderText, this._value,
                                {inputTextSize = FormSettings.defaultInputTextSize,
                                 placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                                 this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    inputElement = TextInputElement.value(this._placeholderText, this._value,
                                          placeholderTextSize: placeholderTextSize,
                                          inputTextSize: inputTextSize);
  }

  LabeledTextInputElement.password(this._labelText, this._placeholderText,
                                   {inputTextSize = FormSettings.defaultInputTextSize,
                                    placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                                    this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = TextInputElement.password(this._placeholderText,
                                             placeholderTextSize: placeholderTextSize,
                                             inputTextSize: inputTextSize);
  }

  LabeledTextInputElement.textArea(this._labelText, this._placeholderText,
                                   {inputTextSize = FormSettings.defaultInputTextSize,
                                    placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                                    this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = TextInputElement.textArea(this._placeholderText);
    inputElement = TextInputElement.textArea(this._placeholderText,
                                             placeholderTextSize: placeholderTextSize,
                                             inputTextSize: inputTextSize);
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
