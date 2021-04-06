import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/tagDisplay/MultiTagDisplayAs.dart';


class Tag extends StatelessWidget
{
  static const Color _defaultTagColor = Colors.grey;
  static const Color _defaultTextColor = Colors.black;
  static const Color _defaultDeleteIconColor = Colors.black;

  String _displayText;
  Color _tagColor;
  Color _textColor;
  Function() _onDeleted;
  Color _deleteIconColor;
  EdgeInsets _padding;
  UniqueKey _key;

  Tag({
    @required String displayText,
    Color tagColor = _defaultTagColor,
    Color textColor = _defaultTextColor,
    Function() onDeleted,
    Color deleteIconColor = _defaultDeleteIconColor,
    EdgeInsets padding = EdgeInsets.zero,
    Key key,
  })
  {
    this._displayText = displayText;
    this._tagColor = tagColor;
    this._textColor = textColor;
    this._onDeleted = onDeleted;
    this._deleteIconColor = deleteIconColor;
    this._padding = padding;

    if (key == null)
    {
      this._key = UniqueKey();
    }
    else
    {
      this._key = key;
    }
  }



  bool keyEquals(Key key)
  {
    return (_key == key);
  }



  static List<Tag> generateList({
    @required List<String> displayText,
    Color tagColor = _defaultTagColor,
    Color textColor = _defaultTextColor,
    Color deleteIconColor = _defaultDeleteIconColor,
    Function(Key) onDeleted,
    double spaceBetweenTags = 5,
    MultiTagDisplayAs displayedAs = MultiTagDisplayAs.Row
  })
  {
    List<Tag> tags = [];

    for (int i = 0; i < displayText.length; i++)
    {
      if (i >= displayText.length - 1)
      {
        spaceBetweenTags = 0;
      }

      Key key = UniqueKey();
      tags.add(Tag(
        displayText: displayText[i],
        tagColor: tagColor,
        textColor: textColor,
        deleteIconColor: deleteIconColor,
        onDeleted: () => onDeleted(key),
        padding: _getEdgeInsets(displayedAs, spaceBetweenTags),
        key: key,
      ));
    }

    return tags;
  }

  static EdgeInsets _getEdgeInsets(MultiTagDisplayAs _displayAs,
                                   double spaceBetweenTags)
  {
    if (_displayAs == MultiTagDisplayAs.Row)
    {
      return EdgeInsets.only(right: spaceBetweenTags);
    }

    else if (_displayAs == MultiTagDisplayAs.Column)
    {
      return EdgeInsets.only(bottom: spaceBetweenTags);
    }

    return EdgeInsets.zero;
  }



  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: _padding,
      child: Chip(
        key: _key,  // Fixes bug if > one Tag has the same _displayText
        backgroundColor: _tagColor,
        label: Text(
          _displayText,
          style: TextStyle(
            color: _textColor,
          ),
        ),
        onDeleted: _onDeleted,
        deleteIconColor: _deleteIconColor,
      )
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})
  {
    return 'Tag{$_displayText}';
  }
}
