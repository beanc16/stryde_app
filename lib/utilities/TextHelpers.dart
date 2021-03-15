import 'package:flutter/cupertino.dart';

class TextHeader extends StatelessWidget
{
  final String _displayText;
  final double _fontSize;

  TextHeader(this._displayText, this._fontSize);

  @override
  Widget build(BuildContext context)
  {
    return Text(
      _displayText,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TextHeader1 extends StatelessWidget
{
  final String _displayText;

  TextHeader1(this._displayText);

  @override
  Widget build(BuildContext context)
  {
    return TextHeader(_displayText, 48);
  }
}

class TextHeader2 extends StatelessWidget
{
  final String _displayText;

  TextHeader2(this._displayText);

  @override
  Widget build(BuildContext context)
  {
    return TextHeader(_displayText, 36);
  }
}