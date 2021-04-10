import 'package:Stryde/components/formHelpers/elements/basic/LabeledInputFormElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FormSettings.dart';

class LabeledNumberInputElement extends LabeledInputFormElement
{
  LabeledNumberInputElement({
    required String labelText,
    required String placeholderText,
    String initialText = "",
    TextEditingController? textEditingController,
    bool isPasswordField = false,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int labelTextSize = FormSettings.defaultLabelTextSize,
    int minInputLength = 0,
    int? maxInputLength,
    CrossAxisAlignment labelAlignment = CrossAxisAlignment.start,
    Color borderColor = Colors.red,
    double borderWidth = 0,
  }) :
    super(
      labelText: labelText,
      placeholderText: placeholderText,
      textInputType: TextInputType.number,
      initialText: initialText,
      textEditingController: textEditingController,
      isPasswordField: isPasswordField,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
      labelTextSize: labelTextSize,
      labelAlignment: labelAlignment,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );


  LabeledNumberInputElement.password({
    required String labelText,
    required String placeholderText,
    String initialText = "",
    TextEditingController? textEditingController,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
    Color borderColor = Colors.red,
    double borderWidth = 0,
  }) :
    super.password(
      labelText: labelText,
      placeholderText: placeholderText,
      textInputType: TextInputType.number,
      initialText: initialText,
      textEditingController: textEditingController,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
}