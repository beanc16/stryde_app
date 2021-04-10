import 'package:Stryde/components/formHelpers/exceptions/InputTooLongException.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooShortException.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FormSettings.dart';
import 'InputFormElement.dart';
import 'LabelText.dart';

class LabeledInputFormElement extends StatelessWidget
{
  late final String _placeholderText;
  late final TextInputType _inputType;
  late TextEditingController _controller;
  late bool _obscureText;
  late final int _inputTextSize;
  late final int _placeholderTextSize;
  late int _minInputLength;
  late int? _maxInputLength;
  late String _labelText;
  late int _labelTextSize;
  late CrossAxisAlignment _labelAlignment;
  late final Color _borderColor;
  late final double _borderWidth;
  late InputFormElement _inputElement;

  int get inputTextSize => _inputTextSize;
  int get placeholderTextSize => _placeholderTextSize;
  int get minInputLength => _minInputLength;
  int? get maxInputLength => _maxInputLength;
  int get inputLength => this._controller.text.length;
  String get inputText => this._controller.text;
  set inputText(String str) => this._controller.text = str;
  bool get showBorder => _inputElement.showBorder;
  set showBorder(bool value) => _inputElement.showBorder = value;
  Color get borderColor => _inputElement.borderColor;
  set borderColor(Color value) => _inputElement.borderColor = borderColor;
  double get borderWidth => _inputElement.borderWidth;
  set borderWidth(double value) => _inputElement.borderWidth = value;


  LabeledInputFormElement({
    required String labelText,
    required String placeholderText,
    required TextInputType textInputType,
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
  })
  {
    _placeholderText = placeholderText;
    _inputType = textInputType;
    _obscureText = isPasswordField;
    _inputTextSize = inputTextSize;
    _placeholderTextSize = placeholderTextSize;
    _minInputLength = minInputLength;
    _maxInputLength = maxInputLength;
    _labelText = labelText;
    _labelTextSize = labelTextSize;
    _labelAlignment = labelAlignment;
    _borderColor = borderColor;
    _borderWidth = borderWidth;

    if (textEditingController == null)
    {
      this._controller = TextEditingController(
        text: initialText
      );
    }
    else
    {
      this._controller = textEditingController;

      if (initialText.length > 0)
      {
        this._controller.text = initialText;
      }
    }

    this._inputElement = InputFormElement(
      placeholderText: _placeholderText,
      textInputType: _inputType,
      textEditingController: _controller,
      isPasswordField: _obscureText,
      inputTextSize: _inputTextSize,
      placeholderTextSize: _placeholderTextSize,
      minInputLength: _minInputLength,
      maxInputLength: _maxInputLength,
      borderColor: _borderColor,
      borderWidth: _borderWidth,
    );
  }

  LabeledInputFormElement.password({
    required String labelText,
    required String placeholderText,
    required TextInputType textInputType,
    String initialText = "",
    TextEditingController? textEditingController,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
    Color borderColor = Colors.red,
    double borderWidth = 0,
  })
  : this(
      labelText: labelText,
      placeholderText: placeholderText,
      textInputType: textInputType,
      initialText: initialText,
      textEditingController: textEditingController,
      isPasswordField: true,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );

  LabeledInputFormElement.textArea({
    required String labelText,
    required String placeholderText,
    String initialText = "",
    TextEditingController? textEditingController,
    bool isPasswordField = false,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
    Color borderColor = Colors.red,
    double borderWidth = 0,
  })
  : this(
      labelText: labelText,
      placeholderText: placeholderText,
      textInputType: TextInputType.multiline,
      initialText: initialText,
      textEditingController: textEditingController,
      isPasswordField: isPasswordField,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );



  bool isEmpty()
  {
    return (this.inputLength == 0);
  }

  bool isValidInput()
  {
    return (this._isAboveMinInput() &&
            this._isUnderMaxInput());
  }

  bool _isAboveMinInput()
  {
    return (this.inputLength >= this._minInputLength);
  }

  bool _isUnderMaxInput()
  {
    if (_maxInputLength == null)
    {
      return true;
    }

    return (this.inputLength <= this._maxInputLength!);
  }

  void tryThrowExceptionMessage()
  {
    if (!this.isValidInput())
    {
      // Input is too small
      if (this.inputLength < this._minInputLength)
      {
        throw InputTooShortException(inputMaxLength: this._minInputLength);
      }

      // Input is too large
      else if (this.inputLength > this._maxInputLength!)
      {
        throw InputTooLongException(inputMinLength: this._maxInputLength!);
      }
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: _labelAlignment,
      children: <Widget>[
        LabelText(
          _labelText,
          labelTextSize: _labelTextSize
        ),

        _inputElement,
      ],
    );
  }
}
