import 'dart:ui';

import 'package:Stryde/components/listViews/searchableListView/SearchableListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class StrydeListTile extends SearchableListTile
{
  StrydeListTile({
    required String displayText,
    double textSize = 20,
    Color? textColor,
    Function(BuildContext, int)? onTapListTile,
    Color onTapColor = Colors.lightBlue,
    required int index,
    double borderWidth = 0,
    Color borderColor = Colors.black,
  }) :
    super(
      displayText, textSize, textColor, onTapListTile,
      onTapColor, index, borderWidth, borderColor,
    );
}