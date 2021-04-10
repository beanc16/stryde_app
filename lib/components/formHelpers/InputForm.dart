import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FormElement.dart';


class InputForm extends StatelessWidget
{
  late final List<FormElement> _formElements;
  late final Widget _submitButton;
  late final List<Widget> _formWidgets;
  late final CrossAxisAlignment _crossAxisAlignment;
  late final MainAxisAlignment _mainAxisAlignment;
  late final EdgeInsets _paddingForForm;
  late final EdgeInsets _paddingForElements;

  InputForm({
    required List<FormElement> formElements,
    required Widget submitButton,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    EdgeInsets paddingForForm = EdgeInsets.zero,
    EdgeInsets paddingForElements = EdgeInsets.zero,
  })
  {
    this._submitButton = submitButton;
    this._formElements = formElements;
    this._crossAxisAlignment = crossAxisAlignment;
    this._mainAxisAlignment = mainAxisAlignment;
    this._paddingForForm = paddingForForm;
    this._paddingForElements = paddingForElements;

    this._formElements.map((element)
    {
      Padding elementWithPadding = Padding(
        padding: _paddingForElements,
        child: element,
      );
      this._formWidgets.add(elementWithPadding);
    });
    this._formWidgets.add(_submitButton);
  }
  
  
  
  bool allInputsAreValid()
  {
    for (int i = 0; i < _formElements.length; i++)
    {
      if (!_formElements[i].isValidInput())
      {
        return false;
      }
    }

    return true;
  }

  void toggleBorders({double? borderWidth,
                     Color? borderColor})
  {
    for (int i = 0; i < _formElements.length; i++)
    {
      if (_formElements[i].isValidInput() && _formElements[i].showBorder)
      {
        _formElements[i].toggleBorder(
          false,
          borderWidth: borderWidth,
          borderColor: borderColor,
        );

        /*
        int index = _formWidgets.indexOf(_formElements[i]);
        _formWidgets.removeAt(index);
        _formWidgets.insert(index, _formElements[i]);
        */
      }

      else if (!_formElements[i].isValidInput() && !_formElements[i].showBorder)
      {
        _formElements[i].toggleBorder(
          true,
          borderWidth: borderWidth,
          borderColor: borderColor,
        );

        /*
        int index = _formWidgets.indexOf(_formElements[i]);
        _formWidgets.removeAt(index);
        _formWidgets.insert(index, _formElements[i]);
        */
      }
    }
  }
  
  
  
  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: _paddingForForm,
      child: Column(
        crossAxisAlignment: _crossAxisAlignment,
        mainAxisAlignment: _mainAxisAlignment,
        children: _formWidgets,
      )
    );
  }
}
