import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchableListTile extends StatelessWidget
{
  // Text
  String _displayText;
  double _textSize;
  Color _textColor;

  // Tap functionality
  void Function(BuildContext, int) _onTapListTile;
  Color _onTapColor;
  int _index;

  // Border
  double _borderWidth;
  Color _borderColor;

  SearchableListTile(this._displayText, this._textSize,
                     this._textColor, this._onTapListTile,
                     this._onTapColor, this._index,
                     this._borderWidth, this._borderColor);



  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: () => _onTapListTile(context, _index),
      splashColor: _onTapColor,

      child: Container(
        // Border
        decoration: BoxDecoration(
          border: Border.all(
            width: _borderWidth,
            color: _borderColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),

        // ListTile
        child: ListTile(
          contentPadding: EdgeInsets.all(5),
          title: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              _displayText,
              style: TextStyle(
                color: _textColor,
                fontSize: _textSize
              ),
            ),
          ),
        )
      )
    );
  }
}