import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late Color borderColor;
  late double borderWidth;
  late bool showBorder;
  late final _maxLines;

  int get inputTextSize => _inputTextSize;
  int get placeholderTextSize => _placeholderTextSize;
  int get minInputLength => _minInputLength;
  int? get maxInputLength => _maxInputLength;
  int get inputLength => controller.text.length;
  String get inputText => controller.text;
  set inputText(String value) => controller.text = value;

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
    Color borderColor = Colors.red,
    double borderWidth = 0,
    int maxLines = 1,
  })
  {
    _placeholderText = placeholderText;
    _inputType = textInputType;
    _obscureText = isPasswordField;
    _inputTextSize = inputTextSize;
    _placeholderTextSize = placeholderTextSize;
    _minInputLength = minInputLength;
    _maxInputLength = maxInputLength;
    this.borderColor = borderColor;
    this.borderWidth = borderWidth;
    _maxLines = maxLines;

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

    if (this.borderWidth <= 0)
    {
      showBorder = false;
    }
    else
    {
      showBorder = true;
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
    Color borderColor = Colors.red,
    double borderWidth = 0,
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
      borderColor: borderColor,
      borderWidth: borderWidth,
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
    Color borderColor = Colors.red,
    double borderWidth = 0,
    int maxLines = 1,
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
      borderColor: borderColor,
      borderWidth: borderWidth,
      maxLines: maxLines,
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



  void toggleBorder(bool showBorder, {double? borderWidth,
                                      Color? borderColor})
  {
    if (borderWidth != null)
    {
      this.borderWidth = borderWidth;
    }

    if (borderColor != null)
    {
      this.borderColor = borderColor;
    }

    this.showBorder = showBorder;
  }



  @override
  State<StatefulWidget> createState()
  {
    return _InputFormElementState(this._placeholderText, this._inputType,
                                  this.controller, this._obscureText,
                                  inputTextSize: this.inputTextSize,
                                  placeholderTextSize: this.placeholderTextSize,
                                  maxInputLength: _maxInputLength,
                                  borderColor: this.borderColor,
                                  borderWidth: this.borderWidth,
                                  showBorder: this.showBorder,
                                  maxLines: this._maxLines);
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
  int? maxInputLength;
  final Color borderColor;
  final double borderWidth;
  bool showBorder;
  int? maxLines;

  // Constructors
  _InputFormElementState(this._placeholderText, this._inputType,
                        this.textEditingController, this._obscureText,
                        {this.inputTextSize = FormSettings.defaultInputTextSize,
                         this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize,
                         this.maxInputLength, this.borderColor = Colors.red,
                         this.borderWidth = 0, this.showBorder = false,
                         this.maxLines = 1})
  {
    if (this._inputType == TextInputType.multiline && this.maxLines! <= 1)
    {
      this.maxLines = null;
    }

    inputElement = TextField(
      controller: this.textEditingController,
      keyboardType: this._inputType,

      decoration: InputDecoration(
        hintText: this._placeholderText,
        hintStyle: TextStyle(
          fontSize: this.placeholderTextSize.toDouble(),
        ),
      ),

      style: TextStyle(
        fontSize: this.inputTextSize.toDouble(),
      ),
      obscureText: _obscureText,

      minLines: 1,
      maxLines: maxLines,
      maxLength: maxInputLength,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
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



  BoxDecoration? _getBorder()
  {
    if (showBorder)
    {
      return BoxDecoration(
        border: Border.all(
          //color: (StrydeColors.darkRedErrorMat[600])!,
          color: borderColor,
          //width: 1.25,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      );
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return Container(
      decoration: _getBorder(),
      child: inputElement,
    );
    //return inputElement;
  }
}
