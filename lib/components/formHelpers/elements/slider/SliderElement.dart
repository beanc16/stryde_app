import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FormSettings.dart';
import '../../exceptions/InputTooShortException.dart';
import '../../exceptions/InputTooLongException.dart';



// Slider - No Label
class SliderElement extends StatefulWidget
{
  int sliderValue;
  double _min;
  double _max;

  SliderElement(this._min, this._max, this.sliderValue);
  
  
  
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
    return SliderElementState(this._min, this._max, this.sliderValue);
  }
}



class SliderElementState extends State<SliderElement>
{
  int sliderValue;
  double _min;
  double _max;
  late Slider slider;

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
