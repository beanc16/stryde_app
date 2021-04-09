import 'package:Stryde/components/formHelpers/exceptions/InputTooLongException.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooShortException.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FormSettings.dart';
import '../basic/LabelText.dart';

class LabeledSliderElement extends StatefulWidget
{
  String _labelText;
  int sliderValue;
  double _min;
  double _max;
  late State<StatefulWidget> state;
  int labelTextSize;

  LabeledSliderElement(this._labelText, this._min, this._max, this.sliderValue,
                       {this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    state = LabeledSliderElementState(this._labelText, this._min, this._max,
                                      this.sliderValue, labelTextSize: labelTextSize);
  }



  bool isValidInput()
  {
    return (this._isAboveMinInput() &&
        this._isUnderMaxInput());
  }

  bool _isAboveMinInput()
  {
    return (this.sliderValue.toDouble() >= this._min);
  }

  bool _isUnderMaxInput()
  {
    return (this.sliderValue.toDouble() <= this._max);
  }

  void tryThrowExceptionMessage()
  {
    if (!this.isValidInput())
    {
      // Input is too small
      if (this.sliderValue < this._min)
      {
        throw InputTooShortException(inputMaxLength: this._min.toInt());
      }

      // Input is too large
      else if (this.sliderValue > this._max)
      {
        throw InputTooLongException(inputMinLength: this._max.toInt());
      }
    }
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
  late Slider slider;
  int labelTextSize;

  LabeledSliderElementState(this._labelText, this._min, this._max, this.sliderValue,
                            {this.labelTextSize = FormSettings.defaultLabelTextSize})
  {
    _displayText = this._labelText + this.sliderValue.toString();
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        LabelText(
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