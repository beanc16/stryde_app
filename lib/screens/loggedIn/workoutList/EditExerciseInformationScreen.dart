import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:workout_buddy/components/tables/EditableTable.dart';
import 'package:workout_buddy/components/tables/EditableTableController.dart';
import 'package:workout_buddy/components/toggleableWidget/EmptyWidget.dart';
import 'package:workout_buddy/models/Exercise.dart';
import 'package:workout_buddy/utilities/TextHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';


class EditExerciseInformationScreen extends StatelessWidget
{
  Exercise _exercise;
  GlobalKey<EditableTableState> _tableKey;
  EditableTableController _controller;

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

  List<dynamic> _getEditedRows()
  {
    //return _controller.getEditedRows();
  }



  Widget _getButtonIcons()
  {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
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



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: StrydeAppBar(titleStr: "View Workout"),
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

              _getButtonIcons(),
              getDefaultPadding(),

              Flexible(
                child: EditableTable(
                  controller: _controller,
                  columns: [
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
                      "title": "Distance",
                      //"widthFactor": 0.2,
                      "key": "distance",
                      "editable": true
                    },
                    {
                      "title": "Resistance",
                      //"widthFactor": 0.2,
                      "key": "resistance",
                      "editable": true
                    },
                  ],
                  rows: [
                    {
                      "setNum": 1,
                      "reps": 20,
                      "weight": 10,
                      "duration": "",
                      "distance": "",
                      "resistance": "",
                    },
                    {
                      "setNum": 2,
                      "reps": 10,
                      "weight": 20,
                      "duration": "",
                      "distance": "",
                      "resistance": "",
                    },
                    {
                      "setNum": 3,
                      "reps": 5,
                      "weight": 25,
                      "duration": "",
                      "distance": "",
                      "resistance": "",
                    },
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}