import 'package:flutter/cupertino.dart';
import '../../FormSettings.dart';
import '../basic/LabeledInputFormElement.dart';

class LabeledTextInputElement extends LabeledInputFormElement
{
  LabeledTextInputElement({
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
  })
  : super(
      labelText: labelText,
      placeholderText: placeholderText,
      textInputType: TextInputType.text,
      initialText: initialText,
      textEditingController: textEditingController,
      isPasswordField: isPasswordField,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
      labelTextSize: labelTextSize,
      labelAlignment: labelAlignment
    );


  LabeledTextInputElement.password({
    required String labelText,
    required String placeholderText,
    String initialText = "",
    TextEditingController? textEditingController,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  })
  : super.password(
      labelText: labelText,
      placeholderText: placeholderText,
      textInputType: TextInputType.text,
      initialText: initialText,
      textEditingController: textEditingController,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
    );


  LabeledTextInputElement.textArea({
    required String labelText,
    required String placeholderText,
    String initialText = "",
    TextEditingController? textEditingController,
    bool isPasswordField = false,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  })
  : super.textArea(
      labelText: labelText,
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