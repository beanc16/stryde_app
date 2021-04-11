import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/widgets/toggleableWidgets/StrydeErrorToggleableWidget.dart';
import 'package:Stryde/components/strydeHelpers/widgets/toggleableWidgets/StrydeSuccessToggleableWidget.dart';
import 'package:Stryde/components/tables/EditableTableController.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidgetMap.dart';
import 'package:Stryde/models/Exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


typedef List<dynamic>? DynamicListCallback();


class EditExerciseInformationButtonRow extends StatefulWidget
{
  late Function() _addNewRow;
  late Function() _deleteLastRow;
  late DynamicListCallback? _getEditedRows;
  late EditableTableController _tableController;
  late Exercise _exercise;

  EditExerciseInformationButtonRow({
    required Function() addNewRow,
    required Function() deleteLastRow,
    required DynamicListCallback? getEditedRows,
    required EditableTableController tableController,
    required Exercise exercise,
  })
  {
    this._addNewRow = addNewRow;
    this._deleteLastRow = deleteLastRow;
    this._getEditedRows = getEditedRows;
    this._tableController = tableController;
    this._exercise = exercise;
  }



  @override
  State<StatefulWidget> createState()
  {
    return EditExerciseInformationButtonRowState(
      this._addNewRow, this._deleteLastRow,
      this._getEditedRows, this._tableController, this._exercise,
    );
  }
}



class EditExerciseInformationButtonRowState extends State<EditExerciseInformationButtonRow>
{
  late Function() _addNewRow;
  late Function() _deleteLastRow;
  late DynamicListCallback? _getEditedRows;
  late EditableTableController _tableController;
  late Exercise _exercise;
  late ToggleableWidgetMap _toggleableWidgets;

  EditExerciseInformationButtonRowState(
    this._addNewRow, this._deleteLastRow,
    this._getEditedRows, this._tableController, this._exercise,
  )
  {
    //_tableController.onTableBuilt = _onTableBuilt;
    _tableController.saveExerciseInfo = _onSave;

    this._toggleableWidgets = ToggleableWidgetMap({
      "successMsg": StrydeSuccessToggleableWidget(
        successMsg: "Save successful",
        showLoadingIndicatorOnLoading: true,
      ),
      "nothingToSaveError": StrydeErrorToggleableWidget(
        errorMsg: "No changes to save",
      ),
      "unknownError": StrydeErrorToggleableWidget(
        errorMsg: "An unknown error occured while saving",
      ),
    });
  }



  void _onTableBuilt(bool isTableBuilt)
  {
    //_isTableSaveable = isTableBuilt;
  }

  void _onSave()
  {
    _showLoadingIcon();

    List<dynamic>? editedRows = _getEditedRows!();

    if (editedRows != null && editedRows.length > 0)
    {
      for (int i = 0; i < editedRows.length; i++)
      {
        int? reps;
        int? weight;
        if (editedRows[i]["reps"] != null)
        {
          reps = int.parse(editedRows[i]["reps"]);
        }
        if (editedRows[i]["weight"] != null)
        {
          weight = int.parse(editedRows[i]["weight"]);
        }

        _exercise.updateInformation(i,
          reps: reps,
          weight: weight,
          duration: editedRows[i]["duration"],
          resistance: editedRows[i]["resistance"],
        );
      }

      print(editedRows.toString());
    }

    else if (editedRows != null && editedRows.length == 0)
    {
      _toggleableWidgets.hideAllExcept("nothingToSaveError")
      .then((value) => _toggleableWidgets.showChildFor(
        "nothingToSaveError", const Duration(seconds: 3),
      ));
    }

    // Null
    else
    {
      _toggleableWidgets.hideAllExcept("unknownError")
      .then((value) => _toggleableWidgets.showChildFor(
        "unknownError", const Duration(seconds: 3),
      ));
    }
  }

  void _showLoadingIcon()
  {
    _toggleableWidgets.hideAllExcept("successMsg")
    .then((value) => _toggleableWidgets.showLoadingIcon("successMsg"));
  }



  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Error & Success messages
          _toggleableWidgets,

          // Add Button
          MaterialButton(
            color: StrydeColors.purple,
            shape: CircleBorder(),
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.add_rounded, color: Colors.white
            ),
            onPressed: _addNewRow,
          ),

          // Delete Button
          MaterialButton(
            color: StrydeColors.purple,
            shape: CircleBorder(),
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.remove_rounded, color: Colors.white
            ),
            onPressed: _deleteLastRow,
            ),

          // Save Button
          MaterialButton(
            color: StrydeColors.purple,
            shape: CircleBorder(),
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.save_rounded, color: Colors.white
            ),
            onPressed: _onSave,
          ),
        ],
      )
    );
  }
}