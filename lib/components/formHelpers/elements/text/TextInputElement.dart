import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FormSettings.dart';
import '../basic/InputFormElement.dart';



// Text - No Label
class TextInputElement extends InputFormElement
{
  TextInputElement({
    required String placeholderText,
    String initialText = "",
    TextEditingController? textEditingController,
    bool isPasswordField = false,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  }) :
    super(
      placeholderText: placeholderText,
      textInputType: TextInputType.text,
      initialText: initialText,
      textEditingController: textEditingController,
      isPasswordField: isPasswordField,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
    );


  TextInputElement.password({
    required String placeholderText,
    TextInputType textInputType = TextInputType.text,
    String initialText = "",
    TextEditingController? textEditingController,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  }) :
    super.password(
      placeholderText: placeholderText,
      textInputType: textInputType,
      initialText: initialText,
      textEditingController: textEditingController,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
    );


  TextInputElement.textArea({
    required String placeholderText,
    String initialText = "",
    TextEditingController? textEditingController,
    bool isPasswordField = false,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  }) :
    super.textArea(
      placeholderText: placeholderText,
      initialText: initialText,
      textEditingController: textEditingController,
      isPasswordField: isPasswordField,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
    );
}
