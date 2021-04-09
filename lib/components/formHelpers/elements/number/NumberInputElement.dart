import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../FormSettings.dart';
import '../basic/InputFormElement.dart';



// Number - No Label
class NumberInputElement extends InputFormElement
{
  NumberInputElement({
    required String placeholderText,
    int? initialNumber,
    TextEditingController? textEditingController,
    bool isPasswordField = false,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  }) :
    super(
      placeholderText: placeholderText,
      textInputType: TextInputType.number,
      initialText: initialNumber.toString(),
      textEditingController: textEditingController,
      isPasswordField: isPasswordField,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
    );


  NumberInputElement.password({
    required String placeholderText,
    TextInputType textInputType = TextInputType.number,
    int? initialNumber,
    TextEditingController? textEditingController,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  }) :
    super.password(
      placeholderText: placeholderText,
      textInputType: textInputType,
      initialText: initialNumber.toString(),
      textEditingController: textEditingController,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
    );
}
