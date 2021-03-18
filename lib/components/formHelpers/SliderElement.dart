import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FormSettings.dart';
import 'LabelTextElement.dart';



// Slider - No Label
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





// Slider - Label
class LabeledSliderElement extends StatefulWidget
{
  String _labelText;
  int sliderValue;
  double _min;
  double _max;
  State<StatefulWidget> state;
  int labelTextSize;

  LabeledSliderElement(this._labelText, this._min, this._max, this.sliderValue,
                       {this.labelTextSize = FormSettings.defaultLabelTextSize})
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
