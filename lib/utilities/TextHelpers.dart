import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget
{
  final String _displayText;
  final double _fontSize;
  Color _color;

  TextHeader(this._displayText, this._fontSize, {Color color})
  {
    _color = color;
  }



  @override
  Widget build(BuildContext context)
  {
    return Text(
      _displayText,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.bold,
        color: _color
      ),
    );
  }
}

class TextHeader1 extends StatelessWidget
{
  final String _displayText;
  Color _color;

  TextHeader1(this._displayText, {Color color})
  {
    _color = color;
  }



  @override
  Widget build(BuildContext context)
  {
    return TextHeader(_displayText, 48, color: _color);
  }
}

class TextHeader2 extends StatelessWidget
{
  final String _displayText;
  Color _color;

  TextHeader2(this._displayText, {Color color})
  {
    _color = color;
  }



  @override
  Widget build(BuildContext context)
  {
    return TextHeader(_displayText, 36, color: _color);
  }
}