import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class WillPopScopeSaveDontSave extends StatelessWidget
{
  Widget _child;
  Function(BuildContext) _onSave;
  Function(BuildContext) _onDontSave;
  Function(BuildContext) _onKeepEditing;
  Color _buttonTextColor;

  WillPopScopeSaveDontSave({
    @required Widget child,
    Color buttonTextColor = Colors.lightBlue,
    Function(BuildContext) onSave,
    Function(BuildContext) onDontSave,
    Function(BuildContext) onKeepEditing,
  })
  {
    this._child = child;
    this._buttonTextColor = buttonTextColor;

    this._onSave = onSave;
    this._onDontSave = onDontSave;
    this._onKeepEditing = onKeepEditing;

    if (onSave == null)
    {
      this._onSave = (context) => _onSaveDefault(context);
    }
    if (onDontSave == null)
    {
      this._onDontSave = (context) => _onDontSaveDefault(context);
    }
    if (onKeepEditing == null)
    {
      this._onKeepEditing = (context) => _onKeepEditingDefault(context);
    }
  }



  void _onKeepEditingDefault(BuildContext context)
  {
    return Navigator.of(context).pop(false);
  }

  void _onDontSaveDefault(BuildContext context)
  {
    return Navigator.of(context).pop(true);
  }

  void _onSaveDefault(BuildContext context)
  {
    return Navigator.of(context).pop(true);
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async
  {
    return (
      await showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            content: Text("Would you like to save your changes?"),
            actions: <Widget>[
              _getTextButton("Keep Editing", _onKeepEditing, context),
              _getTextButton("Don't Save", _onDontSave, context),
              _getTextButton("Save", _onSave, context),
            ],
          );
        }
      )
    ) ?? false;
  }

  TextButton _getTextButton(String displayText,
                            Function(BuildContext) onPress,
                            BuildContext context)
  {
    return TextButton(
      child: Text(
        displayText,
        style: TextStyle(
          color: _buttonTextColor
        ),
      ),
      onPressed: (() => onPress(context)),
    );
  }



  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: _child,
    );
  }
}