import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/*
 * FormHelpers Settings
 */

class FormHelpers
{
  // The size of text typed into
  static const int defaultInputTextSize = 20;
  static const int defaultPlaceholderTextSize = defaultInputTextSize;
  static const int defaultLabelTextSize = 16;
}





/*
 * Input Superclass
 */

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
                              {this.inputTextSize = FormHelpers.defaultInputTextSize,
                               this.placeholderTextSize = FormHelpers.defaultPlaceholderTextSize})
  {
    _obscureText = false;
  }

  InputFormElement.controllerPassword(this._placeholderText, this._inputType,
                                      this.textEditingController,
                                      {this.inputTextSize = FormHelpers.defaultInputTextSize,
                                       this.placeholderTextSize = FormHelpers.defaultPlaceholderTextSize})
  {
    _obscureText = true;
  }

  InputFormElement.value(this._placeholderText, this._inputType, String value,
                         {this.inputTextSize = FormHelpers.defaultInputTextSize,
                          this.placeholderTextSize = FormHelpers.defaultPlaceholderTextSize})
  {
    this.textEditingController = TextEditingController(
      text: value,
    );
    _obscureText = false;
  }

  InputFormElement.valuePassword(this._placeholderText, this._inputType, String value,
                                 {this.inputTextSize = FormHelpers.defaultInputTextSize,
                                  this.placeholderTextSize = FormHelpers.defaultPlaceholderTextSize})
  {
    this.textEditingController = TextEditingController(
      text: value,
    );
    _obscureText = true;
  }

  InputFormElement.password(this._placeholderText, this._inputType,
                            {this.inputTextSize = FormHelpers.defaultInputTextSize,
                             this.placeholderTextSize = FormHelpers.defaultPlaceholderTextSize})
  {
    this.textEditingController = TextEditingController();
    _obscureText = true;
  }

  InputFormElement.textArea(this._placeholderText,
                            {this.inputTextSize = FormHelpers.defaultInputTextSize,
                             this.placeholderTextSize = FormHelpers.defaultPlaceholderTextSize})
  {
    this._inputType = TextInputType.multiline;
    this.textEditingController = TextEditingController();
    _obscureText = false;
  }

  InputFormElement(this._placeholderText, this._inputType,
                   {this.inputTextSize = FormHelpers.defaultInputTextSize,
                    this.placeholderTextSize = FormHelpers.defaultPlaceholderTextSize})
  {
    this.textEditingController = TextEditingController();
    _obscureText = false;
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
                        {this.inputTextSize = FormHelpers.defaultInputTextSize,
                         this.placeholderTextSize = FormHelpers.defaultPlaceholderTextSize})
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
          fontSize: this.placeholderTextSize.toDouble()
        )
      ),

      style: TextStyle(
        fontSize: this.inputTextSize.toDouble()
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





/*
 * Text Element
 */

class LabelTextElement extends StatelessWidget
{
  String _labelText;
  int labelTextSize;

  LabelTextElement(this._labelText,
                   {this.labelTextSize = FormHelpers.defaultLabelTextSize});



  @override
  Widget build(BuildContext context)
  {
    return Text(
      this._labelText,
      style: TextStyle(
        fontSize: this.labelTextSize.toDouble()
      ),
    );
  }
}

// Text - No Label
class TextInputElement extends InputFormElement
{
  TextInputElement(String placeholderText,
                   {inputTextSize = FormHelpers.defaultInputTextSize,
                    placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super(placeholderText, TextInputType.text,
              inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  TextInputElement.controller(String placeholderText, TextEditingController textEditingController,
                              {inputTextSize = FormHelpers.defaultInputTextSize,
                               placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super.controller(placeholderText, TextInputType.text, textEditingController,
                         inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  TextInputElement.value(String placeholderText, String value,
                         {inputTextSize = FormHelpers.defaultInputTextSize,
                          placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super.value(placeholderText, TextInputType.text, value,
                    inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  TextInputElement.password(String placeholderText,
                            {inputTextSize = FormHelpers.defaultInputTextSize,
                             placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super.password(placeholderText, TextInputType.text,
                       inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  TextInputElement.textArea(String placeholderText,
                            {inputTextSize = FormHelpers.defaultInputTextSize,
                             placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super.textArea(placeholderText,
                       inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
}

// Text - Label
class LabeledTextInputElement extends StatelessWidget
{
  String _labelText;
  String _placeholderText;
  String _value;
  TextInputElement inputElement;
  int labelTextSize;


  LabeledTextInputElement(this._labelText, this._placeholderText,
                          {inputTextSize = FormHelpers.defaultInputTextSize,
                           placeholderTextSize = FormHelpers.defaultPlaceholderTextSize,
                           this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = TextInputElement.value(this._placeholderText, this._value,
                                          placeholderTextSize: placeholderTextSize,
                                          inputTextSize: inputTextSize);
  }

  LabeledTextInputElement.value(this._labelText, this._placeholderText, this._value,
                                {inputTextSize = FormHelpers.defaultInputTextSize,
                                 placeholderTextSize = FormHelpers.defaultPlaceholderTextSize,
                                 this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    inputElement = TextInputElement.value(this._placeholderText, this._value,
                                          placeholderTextSize: placeholderTextSize,
                                          inputTextSize: inputTextSize);
  }

  LabeledTextInputElement.password(this._labelText, this._placeholderText,
                                   {inputTextSize = FormHelpers.defaultInputTextSize,
                                    placeholderTextSize = FormHelpers.defaultPlaceholderTextSize,
                                    this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = TextInputElement.password(this._placeholderText,
                                             placeholderTextSize: placeholderTextSize,
                                             inputTextSize: inputTextSize);
  }

  LabeledTextInputElement.textArea(this._labelText, this._placeholderText,
                                   {inputTextSize = FormHelpers.defaultInputTextSize,
                                    placeholderTextSize = FormHelpers.defaultPlaceholderTextSize,
                                    this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = TextInputElement.textArea(this._placeholderText);
    inputElement = TextInputElement.textArea(this._placeholderText,
                                             placeholderTextSize: placeholderTextSize,
                                             inputTextSize: inputTextSize);
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        LabelTextElement(
          this._labelText,
          labelTextSize: this.labelTextSize
        ),

        this.inputElement
      ],
    );
  }
}



// Password - No Label
class PasswordInputElement extends TextInputElement
{
  PasswordInputElement(String placeholderText,
                       {inputTextSize = FormHelpers.defaultInputTextSize,
                        placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super.password(placeholderText, inputTextSize: inputTextSize,
                       placeholderTextSize: placeholderTextSize);
}

// Password - Label
class LabeledPasswordInputElement extends StatelessWidget
{
  String _labelText;
  String _placeholderText;
  String _value;
  TextInputElement inputElement;
  int labelTextSize;


  LabeledPasswordInputElement(this._labelText, this._placeholderText,
                              {inputTextSize = FormHelpers.defaultInputTextSize,
                               placeholderTextSize = FormHelpers.defaultPlaceholderTextSize,
                               this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = TextInputElement.password(this._placeholderText,
                                             inputTextSize: inputTextSize,
                                             placeholderTextSize: placeholderTextSize);
  }

  /*
  LabeledPasswordInputElement.value(this._labelText, this._placeholderText, this._value)
  {
    inputElement = PasswordInputElement.value(this._placeholderText, this._value);
    inputElement = PasswordInputElement(this._placeholderText);
  }
  */



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        LabelTextElement(
          this._labelText,
          labelTextSize: this.labelTextSize
        ),

        this.inputElement
      ],
    );
  }
}





/*
 * Number Element
 */

// No Label
class NumberInputElement extends InputFormElement
{
  NumberInputElement(String placeholderText,
                     {inputTextSize = FormHelpers.defaultInputTextSize,
                      placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super(placeholderText, TextInputType.number,
              inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  NumberInputElement.controller(String placeholderText,
                                TextEditingController textEditingController,
                                {inputTextSize = FormHelpers.defaultInputTextSize,
                                 placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super.controller(placeholderText, TextInputType.number, textEditingController,
                         inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  NumberInputElement.value(String placeholderText, String value,
                           {inputTextSize = FormHelpers.defaultInputTextSize,
                            placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super.value(placeholderText, TextInputType.number, value,
                    inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
}

// Label
class LabeledNumberInputElement extends StatelessWidget
{
  String _labelText;
  String _placeholderText;
  String _value;
  NumberInputElement inputElement;
  int labelTextSize;

  LabeledNumberInputElement(this._labelText, this._placeholderText,
                            {inputTextSize = FormHelpers.defaultInputTextSize,
                             placeholderTextSize = FormHelpers.defaultPlaceholderTextSize,
                             this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    this._value = "";
    this.inputElement = NumberInputElement.value(this._placeholderText, this._value,
                                                 inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
  }

  LabeledNumberInputElement.value(this._labelText, this._placeholderText, this._value,
                                  {inputTextSize = FormHelpers.defaultInputTextSize,
                                   placeholderTextSize = FormHelpers.defaultPlaceholderTextSize,
                                   this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    this.inputElement = NumberInputElement.value(this._placeholderText, this._value,
                                                 inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        LabelTextElement(
          this._labelText,
          labelTextSize: this.labelTextSize
        ),

        this.inputElement,
      ],
    );
  }
}





/*
 * NumberWithOptions Element
 */

// No Label
class NumberWithOptionsInputElement extends InputFormElement
{
  NumberWithOptionsInputElement(String placeholderText,
                                {inputTextSize = FormHelpers.defaultInputTextSize,
                                 placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super(placeholderText, TextInputType.numberWithOptions(decimal: true),
              inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  NumberWithOptionsInputElement.controller(String placeholderText,
                                           TextEditingController textEditingController,
                                           {inputTextSize = FormHelpers.defaultInputTextSize,
                                            placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super.controller(placeholderText, TextInputType.numberWithOptions(decimal: true),
                         textEditingController,
                         inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);

  NumberWithOptionsInputElement.value(String placeholderText, String value,
                                      {inputTextSize = FormHelpers.defaultInputTextSize,
                                       placeholderTextSize = FormHelpers.defaultPlaceholderTextSize}) :
        super.value(placeholderText, TextInputType.numberWithOptions(decimal: true), value,
                    inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
}

// Label
class LabeledNumberWithOptionsInputElement extends StatelessWidget
{
  String _labelText;
  String _placeholderText;
  String _value;
  NumberWithOptionsInputElement inputElement;
  int labelTextSize;

  LabeledNumberWithOptionsInputElement(this._labelText, this._placeholderText,
                                       {inputTextSize = FormHelpers.defaultInputTextSize,
                                        placeholderTextSize = FormHelpers.defaultPlaceholderTextSize,
                                        this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    this._value = "";
    inputElement = NumberWithOptionsInputElement.value(this._placeholderText, this._value,
                                                       inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
  }

  LabeledNumberWithOptionsInputElement.value(this._labelText, this._placeholderText,
                                             this._value,
                                             {inputTextSize = FormHelpers.defaultInputTextSize,
                                              placeholderTextSize = FormHelpers.defaultPlaceholderTextSize,
                                              this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    inputElement = NumberWithOptionsInputElement.value(this._placeholderText, this._value,
                                                       inputTextSize: inputTextSize, placeholderTextSize: placeholderTextSize);
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        LabelTextElement(
          this._labelText,
          labelTextSize: this.labelTextSize
        ),

        this.inputElement,
      ],
    );
  }
}





/*
 * Slider Element
 */

// No Label
class SliderElement extends StatefulWidget
{
  int sliderValue;
  double _min;
  double _max;

  SliderElement(this._min, this._max, this.sliderValue);



  @override
  State<StatefulWidget> createState()
  {
    return SliderElementState(this._min, this._max, this.sliderValue);
  }
}

class SliderElementState extends State<SliderElement>
{
  int sliderValue;
  double _min;
  double _max;
  Slider slider;

  SliderElementState(this._min, this._max, this.sliderValue)
  {
    slider = Slider(
      min: _min,
      max: _max,
      value: sliderValue.toDouble(),

      onChanged: (newValue)
      {
        setState(()
        {
          sliderValue = newValue.toInt();
        });
      },
    );
  }



  @override
  Widget build(BuildContext context)
  {
    return this.slider;
  }
}



// Label
class LabeledSliderElement extends StatefulWidget
{
  String _labelText;
  int sliderValue;
  double _min;
  double _max;
  State<StatefulWidget> state;
  int labelTextSize;

  LabeledSliderElement(this._labelText, this._min, this._max, this.sliderValue,
                       {this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    state = LabeledSliderElementState(this._labelText, this._min, this._max,
                                      this.sliderValue, labelTextSize: labelTextSize);
  }



  @override
  State<StatefulWidget> createState()
  {
    return state;
  }
}

class LabeledSliderElementState extends State<LabeledSliderElement>
{
  String _labelText;
  int sliderValue;
  double _min;
  double _max;
  String _displayText = "";
  Slider slider;
  int labelTextSize;

  LabeledSliderElementState(this._labelText, this._min, this._max, this.sliderValue,
                            {this.labelTextSize = FormHelpers.defaultLabelTextSize})
  {
    _displayText = this._labelText + this.sliderValue.toString();
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        LabelTextElement(
          this._displayText,
          labelTextSize: this.labelTextSize
        ),

        slider = Slider(
          min: _min,
          max: _max,
          value: sliderValue.toDouble(),

          onChanged: (newValue)
          {
            setState(()
            {
              this.sliderValue = newValue.toInt();
              this._displayText = this._labelText + this.sliderValue.toString();
            });
          },
        )
      ],
    );
  }
}
