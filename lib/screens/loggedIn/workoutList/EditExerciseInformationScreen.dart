import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/components/tables/EditableTable.dart';
import 'package:Stryde/components/tables/EditableTableController.dart';
import 'package:Stryde/models/Exercise.dart';
import 'package:Stryde/utilities/TextHelpers.dart';
import 'package:Stryde/utilities/UiHelpers.dart';


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
    /* 
	 * TODO: Add the following items:
	 *       - TextArea for editing description
	 *       - Tags for:
	 *         - Weight Type (body weight / free weight / machine)
	 *         - Muscle Type (compound / isolation)
	 *         - Movement Type (push / pull / quad dominant / etc.)
	 *         - Muscle Group (quads / hams / etc.)
	 *         - Muscle Group Type (big / small)
	 *       - Settings to hide & reorder fields for different exercises
	 */

    Color lGray = StrydeColors.lightGray;
    Color dGray = StrydeColors.darkGray;

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
                  stripeColor1: Color.fromRGBO(lGray.red, lGray.green, lGray.blue, 0.175),
                  stripeColor2: Color.fromRGBO(dGray.red, dGray.green, dGray.blue, 0.2),

                  onRowSaved: (value)
                  {
                    // On save button pressed
                    print("Row saved: " + value.toString());
                  },
                  onSubmitted: (value)
                  {
                    // On edit complete (on mobile) or enter is tapped (on desktop)
                    print("\n\n\nSubmitted: " + value.toString());
                  },

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