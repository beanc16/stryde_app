import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:workout_buddy/components/tagDisplay/MultiTagDisplayAs.dart';


class Tag extends Chip
{
  static const Color _defaultTagColor = Colors.grey;
  static const Color _defaultTextColor = Colors.black;
  static const Color _defaultDeleteIconColor = Colors.black;

  Tag({
    @required String displayText,
    Color tagColor = _defaultTagColor,
    Color textColor = _defaultTextColor,
    Function() onDeleted,
    Color deleteIconColor = _defaultDeleteIconColor,
  }) :
    super(
      backgroundColor: tagColor,
      label: Text(
        displayText,
        style: TextStyle(
          color: textColor,
        ),
      ),
      onDeleted: onDeleted,
      deleteIconColor: deleteIconColor,
    );



  static List<Widget> generateList({
    @required List<String> displayText,
    Color tagColor = _defaultTagColor,
    Color textColor = _defaultTextColor,
    Color deleteIconColor = _defaultDeleteIconColor,
    Function(String) onDeleted,
    double spaceBetweenTags = 5,
    MultiTagDisplayAs displayedAs = MultiTagDisplayAs.Row
  })
  {
    List<Widget> tags = [];

    for (int i = 0; i < displayText.length; i++)
    {
      if (i >= displayText.length - 1)
      {
        spaceBetweenTags = 0;
      }

      tags.add(Padding(
        padding: _getEdgeInsets(displayedAs, spaceBetweenTags),
        child: Tag(
          displayText: displayText[i],
          tagColor: tagColor,
          textColor: textColor,
          deleteIconColor: deleteIconColor,
          onDeleted: () => onDeleted(displayText[i]),
        ),
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
  }
}