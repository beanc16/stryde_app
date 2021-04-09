import 'package:Stryde/components/formHelpers/exceptions/RequiredInputNotEnteredException.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'elements/basic/InputFormElement.dart';


class FormElement extends StatelessWidget
{
  late final InputFormElement _child;
  late final bool _isRequired;
  
  FormElement({
    required InputFormElement child,
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
  
  
  
  @override
  Widget build(BuildContext context)
  {
    return _child;
  }
}
