import 'package:Stryde/components/formHelpers/elements/text/TextInputElement.dart';
import 'package:Stryde/components/strydeHelpers/classes/ExerciseInformationRow.dart';
import 'package:Stryde/components/strydeHelpers/widgets/buttons/EditExerciseInformationButtonRow.dart';
import 'package:Stryde/components/strydeHelpers/widgets/tags/StrydeMultiTagDisplay.dart';
import 'package:Stryde/components/willPopScope/WillPopScopeSaveDontSave.dart';
import 'package:Stryde/models/ExerciseInformation.dart';
import 'package:Stryde/screens/ComingSoonWidget.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
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
  late List<ExerciseInformationRow> _infoRows;

  EditExerciseInformationScreen(this._exercise)
  {
    _tableKey = GlobalKey<EditableTableState>();
    _controller = EditableTableController();
    _infoRows = [];
    int setNum = 1;

    for (int i = 0; i < _exercise.information.length; i++)
    {
      int? numOfSets = _exercise.information[i].sets;
      if (numOfSets != null && numOfSets > 0)
      {
        for (int j = 0; j < numOfSets; j++)
        {
          _infoRows.add(ExerciseInformationRow(
            setNum: setNum,
            info: _exercise.information[i],
          ));
          setNum++;
        }
      }
    }

    // Create an empty set if none exist
    if (_infoRows.length == 0)
    {
      _infoRows.add(ExerciseInformationRow(
        setNum: 1,
        info: ExerciseInformation(),
      ));
    }
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

  void _onAddRow(dynamic addedRow, int addRowIndex)
  {
    Map<dynamic, dynamic> newAddedRow = addedRow;
    newAddedRow["setNum"] = addRowIndex + 1;
  }

  List<String> _getMuscleGroupTagText()
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

    return result;
  }

  List<String> _getExerciseTypeTagText()
  {
    List<String> results = [];

    // Get the muscle groups
    if (_exercise.exerciseWeightType != null)
    {
      results.add(_exercise.exerciseWeightType?.value.toStringShort() ?? "");
    }

    if (_exercise.exerciseMuscleType != null)
    {
      results.add(_exercise.exerciseMuscleType?.value.toStringShort() ?? "");
    }

    if (_exercise.exerciseMovementType != null)
    {
      results.add(_exercise.exerciseMovementType?.value.toStringShort() ?? "");
    }

    return results;
  }



  List<dynamic>? _getEditedRows()
  {
    return _controller.getEditedRows!();
  }

  void _onEditingComplete()
  {
    print("Edit complete");
    //_controller.onChanged();
  }



  List<dynamic> _getInitialTableRows()
  {
    return _infoRows.map(
      (row)
      {
        return row.toJson();
      }
    ).toList();
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



  Future<bool> _onBackButtonPressed(BuildContext context) async
  {
    _controller.saveExerciseInfo();
    NavigateTo.previousScreen(context);
    return true;
  }

  bool _showPopupMenuIf()
  {
    if (this._getEditedRows() != null)
    {
      return (this._getEditedRows())!.isNotEmpty;
    }

    return true;
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
      body: Stack(
        children: [
          WillPopScopeSaveDontSave(
            buttonTextColor: StrydeColors.lightBlue,
            onSave: (BuildContext context) => _onBackButtonPressed(context),
            showPopupMenuIf: _showPopupMenuIf,

            child: Padding(
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
                        maxLines: 4,
                      )
                    ),

                    EditExerciseInformationButtonRow(
                      addNewRow: _addNewRow,
                      deleteLastRow: _deleteLastRow,
                      getEditedRows: _getEditedRows,
                      tableController: _controller,
                      exercise: _exercise,
                    ),

                    Expanded(
                      child: EditableTable(
                        controller: _controller,
                        columns: _getInitialTableColumns(),
                        rows: _getInitialTableRows(),

                        stripeColor1: (StrydeColors.lightGrayMat[100])!,
                        stripeColor2: (StrydeColors.darkGrayMat[200])!,
                        columnRatio: 0.175,

                        onAddRow: _onAddRow,
                        onEditingComplete: _onEditingComplete,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: StrydeMultiTagDisplay(
                          displayText: _getMuscleGroupTagText(),
                          canDeleteTags: false,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: StrydeMultiTagDisplay(
                          displayText: _getExerciseTypeTagText(),
                          canDeleteTags: false,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            )
          ),
          ComingSoonWidget(),
        ],
      ),
    );
  }
}