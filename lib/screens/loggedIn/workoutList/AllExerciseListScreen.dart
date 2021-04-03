import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:workout_buddy/components/formHelpers/LabelTextElement.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/StrydeExerciseSearchableListView.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/StrydeProgressIndicator.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/tags/StrydeMultiTagDisplay.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/text/StrydeErrorText.dart';
import 'package:workout_buddy/components/toggleableWidget/ToggleableWidget.dart';
import 'package:workout_buddy/models/Exercise.dart';
import 'package:workout_buddy/models/MuscleGroup.dart';
import 'package:workout_buddy/utilities/HttpQueryHelper.dart';


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
  List<Exercise> _exercises;
  List<String> _listTileDisplayText;
  ToggleableWidget _loadingErrorMsg;
  List<Map< String, dynamic>> _selectedExercises;
  StrydeMultiTagDisplay _selectExercisesTagDisplay;

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
      this._exercises = StrydeUserStorage.allExercises;

      // Convert _exercises to _listTileDisplayText
      _listTileDisplayText = _exercises.map((e) => e.name).toList();

      // Hide loading icon & error msg
      _loadingErrorMsg.hideChildAndLoadingIcon();
    }

    else
    {
      // Get all exercises available to the user
      HttpQueryHelper.get(
        "/user/exercises/",
        onSuccess: (dynamic response) => _onGetExercisesSuccess(response),
        onFailure: (dynamic response) => _onGetExercisesFail(response)
      );
    }
  }

  void _onGetExercisesSuccess(Map<String, dynamic> workoutsJson)
  {
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
        exercise["exerciseId"], exercise["exerciseName"],
        exercise["exerciseDescription"],
        exercise["exerciseWeightTypeName"],
        exercise["exerciseMuscleTypeName"],
        exercise["exerciseMovementTypeName"], muscleGroups
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
        child: _loadingErrorMsg,
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
                child: _selectExercisesTagDisplay,
              ),
            ]
          )
        );
      }

      else
      {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: LabelTextElement("No exercises..."),
        );
      }
    }
  }



  void _onTapExerciseListTile(BuildContext context, int index)
  {
    setState(()
    {
      _selectedExercises.add({
        "exercise": _exercises[index],
        "displayText": _listTileDisplayText[index],
      });

      _selectExercisesTagDisplay.addTag(_listTileDisplayText[index]);
    });

    print("\n\n_selectedExercises: " + _selectedExercises.toString());
  }

  void _onDeselectExerciseTag(int index, String displayStr)
  {
    setState(()
    {
      _selectedExercises.removeAt(index);
    });
  }



  @override
  Widget build(BuildContext context)
  {
    _fetchExercises();

    return Scaffold(
      appBar: StrydeAppBar(titleStr: "Add Exercise"),
      body: _getWidgetToDisplay(),
    );
  }
}
