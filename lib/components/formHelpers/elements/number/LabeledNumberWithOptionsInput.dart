import 'package:Stryde/components/formHelpers/elements/basic/LabeledInputFormElement.dart';
import 'package:flutter/cupertino.dart';
import '../../FormSettings.dart';

class LabeledNumberWithOptionsInputElement extends LabeledInputFormElement
{
  LabeledNumberWithOptionsInputElement({
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
  }) :
    super(
      labelText: labelText,
      placeholderText: placeholderText,
      textInputType: TextInputType.numberWithOptions(),
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


  LabeledNumberWithOptionsInputElement.password({
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
      textInputType: TextInputType.numberWithOptions(),
      initialText: initialText,
      textEditingController: textEditingController,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
    );
}