import 'package:Stryde/components/formHelpers/elements/text/TextInputElement.dart';
import 'package:Stryde/components/strydeHelpers/widgets/tags/StrydeMultiTagDisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/components/tables/EditableTable.dart';
import 'package:Stryde/components/tables/EditableTableController.dart';
import 'package:Stryde/models/Exercise.dart';
import 'package:Stryde/utilities/TextHelpers.dart';
import '../../../models/enums/ExerciseMovementTypeEnum.dart';
import '../../../models/enums/ExerciseMuscleTypeEnum.dart';
import '../../../models/enums/ExerciseWeightTypeEnum.dart';
import '../../../models/enums/MuscleGroupEnum.dart';


class EditExerciseInformationScreen extends StatelessWidget
{
  Exercise _exercise;
  late final GlobalKey<EditableTableState> _tableKey;
  late final EditableTableController _controller;

  EditExerciseInformationScreen(this._exercise)
  {
    _tableKey = GlobalKey<EditableTableState>();
    _controller = EditableTableController();
  }



  void _addNewRow()
  {
    _controller.addNewRow();
  }

  void _deleteLastRow()
  {
    _controller.deleteLastRow();
  }

  void _deleteRow(int index)
  {
    //_controller.deleteRow();
  }

  /*
  List<dynamic> _getEditedRows()
  {
    //return _controller.getEditedRows();
  }
   */

  void _onAddRow(dynamic addedRow, int addRowIndex)
  {
    Map<dynamic, dynamic> newAddedRow = addedRow;
    newAddedRow["setNum"] = addRowIndex + 1;
  }

  List<String> _getExerciseTypeTagText()
  {
    // Get the muscle groups
    List<String> result = [];
    if (_exercise.muscleGroups != null)
    {
      result = (_exercise.muscleGroups)!.map(
      (mg)
      {
        return mg.value.toStringShort();
      }).toList();
    }

    // Add the exercise types
    result.addAll([
      _exercise.exerciseWeightType?.value.toStringShort() ?? "",
      _exercise.exerciseMuscleType?.value.toStringShort() ?? "",
      _exercise.exerciseMovementType?.value.toStringShort() ?? "",
    ]);

    return result;
  }



  List<dynamic>? _getEditedRows()
  {
    return _controller.getEditedRows!();
  }



  Widget _getButtonIcons()
  {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Add Button
          MaterialButton(
            color: StrydeColors.purple,
            shape: CircleBorder(),
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.add, color: Colors.white
            ),
            onPressed: _addNewRow,
          ),

          // Delete Button
          MaterialButton(
            color: StrydeColors.purple,
            shape: CircleBorder(),
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.remove, color: Colors.white
            ),
            onPressed: _deleteLastRow,
          ),
        ],
      )
    );
  }

  List<dynamic> _getInitialTableRows()
  {
    return [
      {
        "setNum": 1,
        "reps": 20,
        "weight": 10,
        "duration": "",
        "resistance": "",
      },
      {
        "setNum": 2,
        "reps": 10,
        "weight": 20,
        "duration": "",
        "resistance": "",
      },
      {
        "setNum": 3,
        "reps": 5,
        "weight": 25,
        "duration": "",
        "resistance": "",
      },
    ];
  }

  List<dynamic> _getInitialTableColumns()
  {
    return [
      {
        "title": "Set Number",
        //"widthFactor": 0.2,
        "key": "setNum",
        "editable": false
      },
      {
        "title": "Reps",
        //"widthFactor": 0.2,
        "key": "reps",
        "editable": true
      },
      {
        "title": "Weight",
        //"widthFactor": 0.2,
        "key": "weight",
        "editable": true
      },
      {
        "title": "Duration",
        //"widthFactor": 0.2,
        "key": "duration",
        "editable": true
      },
      {
        "title": "Resistance",
        //"widthFactor": 0.2,
        "key": "resistance",
        "editable": true
      },
    ];
  }



  @override
  Widget build(BuildContext context)
  {
    /* 
	 * TODO: Add the following items:
	 *       - Settings to hide & reorder fields for different exercises
	 */

    return Scaffold(
      appBar: StrydeAppBar(titleStr: "Edit Exercise"),
      key: _tableKey,
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextHeader1(
                displayText: _exercise.name,
                color: StrydeColors.darkGray,
              ),

              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextInputElement.textArea(
                  placeholderText: "Enter description",
                  maxInputLength: 2000,
                  initialText: _exercise.description ?? "",
                  maxLines: 5,
                )
              ),

              _getButtonIcons(),

              Flexible(
                child: EditableTable(
                  controller: _controller,
                  columns: _getInitialTableColumns(),
                  rows: _getInitialTableRows(),

                  stripeColor1: (StrydeColors.lightGrayMat[100])!,
                  stripeColor2: (StrydeColors.darkGrayMat[200])!,
                  columnRatio: 0.175,

                  onAddRow: _onAddRow,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 15),
                child: StrydeMultiTagDisplay(
                  displayText: _getExerciseTypeTagText(),
                  canDeleteTags: false,
                ),
              )
            ],
          ),
        )
      )
    );
  }
}