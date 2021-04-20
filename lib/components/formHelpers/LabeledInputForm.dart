import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LabeledFormElement.dart';


class LabeledInputForm extends StatelessWidget
{
  late final List<LabeledFormElement> _labeledFormElements;
  late final Widget _submitButton;
  late final List<Widget> _formWidgets = [];
  late final CrossAxisAlignment _crossAxisAlignment;
  late final MainAxisAlignment _mainAxisAlignment;
  late final EdgeInsets _paddingForForm;
  late final EdgeInsets _paddingForElements;

  LabeledInputForm({
    required List<LabeledFormElement> formElements,
    required Widget submitButton,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    EdgeInsets paddingForForm = EdgeInsets.zero,
    EdgeInsets paddingForElements = EdgeInsets.zero,
  })
  {
    this._submitButton = submitButton;
    this._labeledFormElements = formElements;
    this._crossAxisAlignment = crossAxisAlignment;
    this._mainAxisAlignment = mainAxisAlignment;
    this._paddingForForm = paddingForForm;
    this._paddingForElements = paddingForElements;

    List<Padding> paddedElements = this._labeledFormElements.map((element)
    {
      return Padding(
        padding: _paddingForElements,
        child: element,
      );
    }).toList();

    this._formWidgets.addAll(paddedElements);
    this._formWidgets.add(_submitButton);
  }
  
  
  
  bool allInputsAreValid()
  {
    for (int i = 0; i < _labeledFormElements.length; i++)
    {
      if (!_labeledFormElements[i].isValidInput())
      {
        return false;
      }
    }

    return true;
  }

  void tryThrowExceptionMessage()
  {
    for (int i = 0; i < _labeledFormElements.length; i++)
    {
      _labeledFormElements[i].tryThrowExceptionMessage();
    }
  }

  void toggleBorders({double? borderWidth,
                     Color? borderColor})
  {
    for (int i = 0; i < _labeledFormElements.length; i++)
    {
      if (_labeledFormElements[i].isValidInput() &&
          _labeledFormElements[i].showBorder)
      {
        _labeledFormElements[i].toggleBorder(
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

      else if (!_labeledFormElements[i].isValidInput() &&
               !_labeledFormElements[i].showBorder)
      {
        _labeledFormElements[i].toggleBorder(
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
