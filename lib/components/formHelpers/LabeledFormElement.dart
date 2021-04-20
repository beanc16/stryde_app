import 'package:Stryde/components/formHelpers/exceptions/RequiredInputNotEnteredException.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'elements/basic/LabeledInputFormElement.dart';


class LabeledFormElement extends StatelessWidget
{
  late final LabeledInputFormElement _child;
  late final bool _isRequired;

  bool get showBorder => _child.showBorder;

  LabeledFormElement({
    required LabeledInputFormElement child,
    required bool isRequired,
  })
  {
    this._child = child;
    this._isRequired = isRequired;
  }
  
  
  
  bool isValidInput()
  {
    return (_child.isValidInput() &&
           (!_isRequired || _isRequiredAndNotEmpty()));
  }

  bool _isRequiredAndNotEmpty()
  {
    return (_isRequired && !_child.isEmpty());
  }

  void tryThrowExceptionMessage()
  {
    if (_isRequired && _child.isEmpty())
    {
      throw RequiredInputNotEnteredException();
    }

    _child.tryThrowExceptionMessage();
  }

  void toggleBorder(bool showBorder, {double? borderWidth,
                    Color? borderColor})
  {
    if (borderWidth != null)
    {
      _child.borderWidth = borderWidth;
    }

    if (borderColor != null)
    {
      _child.borderColor = borderColor;
    }

    _child.showBorder = showBorder;
  }
  
  
  
  @override
  Widget build(BuildContext context)
  {
    return _child;
  }
}
