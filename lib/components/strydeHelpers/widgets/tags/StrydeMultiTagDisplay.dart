import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:workout_buddy/components/tagDisplay/MultiTagDisplay.dart';
import 'package:workout_buddy/components/tagDisplay/MultiTagDisplayAs.dart';


class StrydeMultiTagDisplay extends MultiTagDisplay
{
  StrydeMultiTagDisplay({
    @required List<String> displayText,
    Function(int, String) onDeleteTag,
  }) :
      super(
        displayText: displayText,
        tagColor: StrydeColors.darkBlue,
        textColor: Colors.white,
        deleteIconColor: Color.fromRGBO(255, 255, 255, 0.75), // Transparent white
        mainAxisAlignment: MainAxisAlignment.start,
        onDeleteTag: onDeleteTag,
        spaceBetweenTags: 15,
      );
}