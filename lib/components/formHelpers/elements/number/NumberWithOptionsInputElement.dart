import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FormSettings.dart';
import '../basic/InputFormElement.dart';



// Number - No Label
class NumberWithOptionsInputElement extends InputFormElement
{
  NumberWithOptionsInputElement({
    required String placeholderText,
    int? initialNumber,
    TextEditingController? textEditingController,
    bool isPasswordField = false,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
    Color borderColor = Colors.red,
    double borderWidth = 0,
  }) :
    super(
      placeholderText: placeholderText,
      textInputType: TextInputType.numberWithOptions(),
      initialText: initialNumber.toString(),
      textEditingController: textEditingController,
      isPasswordField: isPasswordField,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );


  NumberWithOptionsInputElement.password({
    required String placeholderText,
    int? initialNumber,
    TextEditingController? textEditingController,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
    Color borderColor = Colors.red,
    double borderWidth = 0,
  }) :
    super.password(
      placeholderText: placeholderText,
      textInputType: TextInputType.numberWithOptions(),
      initialText: initialNumber.toString(),
      textEditingController: textEditingController,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
}
