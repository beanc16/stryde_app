import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FormSettings.dart';
import '../../exceptions/InputTooLongException.dart';
import '../../exceptions/InputTooShortException.dart';



// No Label
class InputFormElement extends StatefulWidget
{
  // Variables
  late final String _placeholderText;
  late final TextInputType _inputType;
  late final TextEditingController controller;
  late bool _obscureText;
  late final int _inputTextSize;
  late final int _placeholderTextSize;
  late final int _minInputLength;
  late final int? _maxInputLength;

  int get inputTextSize => _inputTextSize;
  int get placeholderTextSize => _placeholderTextSize;
  int get minInputLength => _minInputLength;
  int? get maxInputLength => _maxInputLength;
  int get inputLength => this.controller.text.length;
  String get inputText => this.controller.text;
  set inputText(String str) => this.controller.text = str;

  InputFormElement({
    required String placeholderText,
    required TextInputType textInputType,
    String initialText = "",
    TextEditingController? textEditingController,
    bool isPasswordField = false,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  })
  {
    _placeholderText = placeholderText;
    _inputType = textInputType;
    _obscureText = isPasswordField;
    _inputTextSize = inputTextSize;
    _placeholderTextSize = placeholderTextSize;
    _minInputLength = minInputLength;
    _maxInputLength = maxInputLength;

    if (textEditingController == null)
    {
      this.controller = TextEditingController(
        text: initialText
      );
    }
    else
    {
      this.controller = textEditingController;

      if (initialText.length > 0)
      {
        this.controller.text = initialText;
      }
    }
  }

  InputFormElement.password({
    required String placeholderText,
    required TextInputType textInputType,
    String initialText = "",
    TextEditingController? textEditingController,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  })
  : this(
      placeholderText: placeholderText,
      textInputType: textInputType,
      initialText: initialText,
      textEditingController: textEditingController,
      isPasswordField: true,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
    );

  InputFormElement.textArea({
    required String placeholderText,
    String initialText = "",
    TextEditingController? textEditingController,
    bool isPasswordField = false,
    int inputTextSize = FormSettings.defaultInputTextSize,
    int placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
    int minInputLength = 0,
    int? maxInputLength,
  })
  : this(
      placeholderText: placeholderText,
      textInputType: TextInputType.multiline,
      initialText: initialText,
      textEditingController: textEditingController,
      isPasswordField: isPasswordField,
      inputTextSize: inputTextSize,
      placeholderTextSize: placeholderTextSize,
      minInputLength: minInputLength,
      maxInputLength: maxInputLength,
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
  State<StatefulWidget> createState()
  {
    return _InputFormElementState(this._placeholderText, this._inputType,
                                  this.controller, this._obscureText,
                                  inputTextSize: this.inputTextSize,
                                  placeholderTextSize: this.placeholderTextSize);
  }
}



class _InputFormElementState extends State<InputFormElement>
{
  // Variables
  final String _placeholderText;
  final TextInputType _inputType;
  final TextEditingController textEditingController;
  final bool _obscureText;
  late TextField inputElement;
  final int inputTextSize;
  final int placeholderTextSize;

  // Constructors
  _InputFormElementState(this._placeholderText, this._inputType,
                        this.textEditingController, this._obscureText,
                        {this.inputTextSize = FormSettings.defaultInputTextSize,
                         this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize})
  {
    int? maxLines = 1;
    if (this._inputType == TextInputType.multiline)
    {
      maxLines = null;
    }

    inputElement = TextField(
      controller: this.textEditingController,
      keyboardType: this._inputType,

      decoration: InputDecoration(
        hintText: this._placeholderText,
        hintStyle: TextStyle(
          fontSize: this.placeholderTextSize.toDouble(),
        )
      ),

      style: TextStyle(
        fontSize: this.inputTextSize.toDouble(),
      ),
      obscureText: _obscureText,

      maxLines: maxLines,
    );
  }



  void reset()
  {
    textEditingController.clear();
  }

  @override
  void dispose()
  {
    super.dispose();
    textEditingController.dispose();
  }



  @override
  Widget build(BuildContext context)
  {
    return inputElement;
  }
}
