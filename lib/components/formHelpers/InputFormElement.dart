import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FormSettings.dart';



// No Label
class InputFormElement extends StatefulWidget
{
  // Variables
  final String _placeholderText;
  TextInputType _inputType;
  TextEditingController textEditingController;
  bool _obscureText;
  final int inputTextSize;
  final int placeholderTextSize;

  // Constructors
  InputFormElement.controller(this._placeholderText, this._inputType,
                              this.textEditingController,
                              {this.inputTextSize = FormSettings.defaultInputTextSize,
                               this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize})
  {
    _obscureText = false;
  }

  InputFormElement.controllerPassword(this._placeholderText, this._inputType,
                                      this.textEditingController,
                                      {this.inputTextSize = FormSettings.defaultInputTextSize,
                                       this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize})
  {
    _obscureText = true;
  }

  InputFormElement.value(this._placeholderText, this._inputType, String value,
                         {this.inputTextSize = FormSettings.defaultInputTextSize,
                          this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize})
  {
    this.textEditingController = TextEditingController(
      text: value,
    );
    _obscureText = false;
  }

  InputFormElement.valuePassword(this._placeholderText, this._inputType, String value,
                                 {this.inputTextSize = FormSettings.defaultInputTextSize,
                                  this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize})
  {
    this.textEditingController = TextEditingController(
      text: value,
    );
    _obscureText = true;
  }

  InputFormElement.password(this._placeholderText, this._inputType,
                            {this.inputTextSize = FormSettings.defaultInputTextSize,
                             this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize})
  {
    this.textEditingController = TextEditingController();
    _obscureText = true;
  }

  InputFormElement.textArea(this._placeholderText,
                            {this.inputTextSize = FormSettings.defaultInputTextSize,
                             this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize})
  {
    this._inputType = TextInputType.multiline;
    this.textEditingController = TextEditingController();
    _obscureText = false;
  }

  InputFormElement(this._placeholderText, this._inputType,
                   {this.inputTextSize = FormSettings.defaultInputTextSize,
                    this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize})
  {
    this.textEditingController = TextEditingController();
    _obscureText = false;
  }



  String getInputText()
  {
    return this.textEditingController.text;
  }

  void setInputText(String str)
  {
    this.textEditingController.text = str;
  }



  @override
  State<StatefulWidget> createState()
  {
    return InputFormElementState(this._placeholderText, this._inputType,
                                 this.textEditingController, this._obscureText,
                                 inputTextSize: this.inputTextSize,
                                 placeholderTextSize: this.placeholderTextSize);
  }
}



// Label
class InputFormElementState extends State<InputFormElement>
{
  // Variables
  final String _placeholderText;
  final TextInputType _inputType;
  final TextEditingController textEditingController;
  final bool _obscureText;
  TextField inputElement;
  final int inputTextSize;
  final int placeholderTextSize;

  // Constructors
  InputFormElementState(this._placeholderText, this._inputType,
                        this.textEditingController, this._obscureText,
                        {this.inputTextSize = FormSettings.defaultInputTextSize,
                         this.placeholderTextSize = FormSettings.defaultPlaceholderTextSize})
  {
    int maxLines = 1;
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
