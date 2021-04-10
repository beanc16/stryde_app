import 'package:Stryde/components/formHelpers/elements/basic/LabelText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'file:///C:/Users/cbean/Documents/Homework/MSJ/20-21%20(Fall)/Senior%20Research/Bean%20Senior%20Project%20-%20App/workout_buddy_web/lib/components/strydeHelpers/widgets/listView/StrydeExerciseSearchableListView.dart';
import 'package:Stryde/components/strydeHelpers/widgets/StrydeProgressIndicator.dart';
import 'package:Stryde/components/strydeHelpers/widgets/tags/StrydeMultiTagDisplay.dart';
import 'package:Stryde/components/strydeHelpers/widgets/text/StrydeErrorText.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidget.dart';
import 'package:Stryde/models/Exercise.dart';
import 'package:Stryde/models/MuscleGroup.dart';
import 'package:Stryde/utilities/HttpQueryHelper.dart';
import 'package:Stryde/utilities/NavigateTo.dart';


class AllExerciseListScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return AllExerciseListState();
  }
}



class AllExerciseListState extends State<AllExerciseListScreen>
{
  late List<Exercise> _exercises;
  late List<String> _listTileDisplayText;
  late ToggleableWidget _loadingErrorMsg;
  late List<Exercise> _selectedExercises;
  late StrydeMultiTagDisplay _selectExercisesTagDisplay;

  @override
  void initState()
  {
    super.initState();

    _loadingErrorMsg = _getLoadingErrorMsg();
    _exercises = [];
    _listTileDisplayText = [];
    _selectedExercises = [];
    _selectExercisesTagDisplay = StrydeMultiTagDisplay(
      displayText: [],
      onDeleteTag: (int index, String displayStr) =>
                          _onDeselectExerciseTag(index, displayStr),
    );

    // Get exercises after build method is called
    WidgetsBinding.instance?.addPostFrameCallback((timestamp) =>
                                                    _fetchExercises());
  }

  ToggleableWidget _getLoadingErrorMsg()
  {
    return ToggleableWidget(
      isLoading: true,
      loadingIndicator: StrydeProgressIndicator(),
      child: StrydeErrorText(displayText: "Error loading exercises"),
    );
  }



  void _fetchExercises() async
  {
    _loadingErrorMsg.showLoadingIcon();

    if (StrydeUserStorage.allExercises != null)
    {
      this._exercises = StrydeUserStorage.allExercises ?? [];

      // Convert _exercises to _listTileDisplayText
      setState(()
      {
        _listTileDisplayText = _exercises.map((e) => e.name).toList();
      });

      // Hide loading icon & error msg
      _loadingErrorMsg.hideChildAndLoadingIcon();
    }

    else
    {
      // Get all exercises available to the user
      HttpQueryHelper.get(
        "/user/exercises",
        onSuccess: (dynamic response) => _onGetExercisesSuccess(response),
        onFailure: (dynamic response) => _onGetExercisesFail(response)
      );
    }
  }

  void _onGetExercisesSuccess(Map<String, dynamic> workoutsJson)
  {
    print("");
    print(workoutsJson["_results"].toString());
    print("");
    // Convert exercises to model
    _convertExerciseResults(workoutsJson["_results"]);

    // Save to session-long storage
    StrydeUserStorage.allExercises = this._exercises;

    // Convert _exercises to _listTileDisplayText
    setState(()
    {
      _listTileDisplayText = _exercises.map((e) => e.name).toList();
    });

    // Hide loading icon & error msg
    _loadingErrorMsg.hideChildAndLoadingIcon();
  }

  void _onGetExercisesFail(dynamic results)
  {
    // Show error message
    _loadingErrorMsg.hideLoadingIcon();
    _loadingErrorMsg.showChild();

    print("_onGetExercisesFail:\n" + results.toString());
  }

  void _convertExerciseResults(List<dynamic> exerciseList)
  {
    for (int i = 0; i < exerciseList.length; i++)
    {
      // Helper variables
      Map<String, dynamic> exercise = exerciseList[i];
      List<dynamic> muscleGroupInfo = exercise["mgInfo"];

      // Get a list of the current exercise's muscle groups
      List<MuscleGroup> muscleGroups = [];
      for (int i = 0; i < muscleGroupInfo.length; i++)
      {
        // Convert muscle group info to a model
        MuscleGroup mg = MuscleGroup(muscleGroupInfo[i]["mgName"]);
        muscleGroups.add(mg);
      }

      // Convert exercise info to a model and add it to _exercises
      Exercise ex = Exercise.model(
        exercise["exerciseId"],
        exercise["exerciseName"],
        exercise["exerciseDescription"],
        exercise["exerciseWeightTypeName"],
        exercise["exerciseMuscleTypeName"],
        exercise["exerciseMovementTypeName"],
        muscleGroups,
      );

      setState(()
      {
        this._exercises.add(ex);
      });
    }
  }



  Widget _getWidgetToDisplay()
  {
    if (_loadingErrorMsg.childOrLoadingIconIsVisible())
    {
      return Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        alignment: Alignment.topCenter,
        child: Center(
          child: _loadingErrorMsg
        ),
      );
    }

    else
    {
      if (this._listTileDisplayText.length > 0)
      {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              Expanded(
                child: StrydeExerciseSearchableListView(
                  listTileDisplayText: _listTileDisplayText,
                  onTapListTile: (BuildContext context, int index) =>
                                  _onTapExerciseListTile(context, index),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelText(
                      "Selected Exercises",
                      labelTextSize: 14,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: _selectExercisesTagDisplay,
                    ),
                  ],
                ),
              ),
            ]
          )
        );
      }

      else
      {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: LabelText("No exercises..."),
        );
      }
    }
  }



  void _onTapExerciseListTile(BuildContext context, int index)
  {
    _selectedExercises.add(_exercises[index]);

    setState(()
    {
      _selectExercisesTagDisplay.addTag(_listTileDisplayText[index]);
    });
  }

  void _onDeselectExerciseTag(int index, String displayStr)
  {
    setState(()
    {
      _selectedExercises.removeAt(index);
    });
  }



  Future<bool> _onBackButtonPressed(BuildContext context) async
  {
    // Send the selected exercises back to the previous screen
    NavigateTo.previousScreenWithData(context, _selectedExercises);

    // True vs False doesn't matter in this case
    return true;
  }



  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: _getWidgetToDisplay(),
      /*
      child: Scaffold(
        appBar: StrydeAppBar(titleStr: "Add Exercise"),
        body: _getWidgetToDisplay()
      ),
       */
    );
  }
}
