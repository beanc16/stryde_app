import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget
{
  late final String _displayText;
  late final double _fontSize;
  late final Color? _color;

  TextHeader({
    required String displayText,
    required double fontSize,
    Color? color
  })
  {
    _displayText = displayText;
    _fontSize = fontSize;
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
  late final String _displayText;
  late final Color? _color;

  TextHeader1({
    required String displayText,
    Color? color
  })
  {
    _displayText = displayText;
    _color = color;
  }



  @override
  Widget build(BuildContext context)
  {
    return TextHeader(
      displayText: _displayText,
      fontSize: 48,
      color: _color,
    );
  }
}



class TextHeader2 extends StatelessWidget
{
  late final String _displayText;
  late final Color? _color;

  TextHeader2({
    required String displayText,
    Color? color
  })
  {
    _displayText = displayText;
    _color = color;
  }



  @override
  Widget build(BuildContext context)
  {
    return TextHeader(
      displayText: _displayText,
      fontSize: 36,
      color: _color,
    );
  }
}