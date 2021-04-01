import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:workout_buddy/components/colors/StrydeColors.dart';
import 'package:workout_buddy/components/formHelpers/LabelTextElement.dart';
import 'package:workout_buddy/components/listViews/searchableListView/SearchableListView.dart';
import 'package:workout_buddy/components/nav/StrydeAppBar.dart';
import 'package:workout_buddy/components/strydeHelpers/StrydeUserStorage.dart';
import 'package:workout_buddy/models/Exercise.dart';
import 'package:workout_buddy/models/MuscleGroup.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';
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
  bool _isLoading;
  bool _hasError;
  Center _loadingIcon;
  List<Map< String, dynamic>> _selectedExercises;

  @override
  void initState()
  {
    _isLoading = false;
    _hasError = false;
    _exercises = [];
    _listTileDisplayText = [];
    _selectedExercises = [];

    _loadingIcon = getCircularProgressIndicatorCentered();

    _fetchExercises();
  }



  void _fetchExercises() async
  {
    setIsLoading(true);

    if (StrydeUserStorage.allExercises != null)
    {
      this._exercises = StrydeUserStorage.allExercises;

      // Convert _exercises to _listTileDisplayText
      _listTileDisplayText = _exercises.map((e) => e.name).toList();

      setIsLoading(false);
      setHasError(false);
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
    _listTileDisplayText = _exercises.map((e) => e.name).toList();

    setIsLoading(false);
    setHasError(false);
  }

  void _onGetExercisesFail(dynamic results)
  {
    print("_onGetExercisesFail:\n" + results.toString());

    setIsLoading(false);
    setHasError(true);
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



  void setIsLoading(bool isLoading)
  {
    setState(()
    {
      this._isLoading = isLoading;
    });
  }

  void setHasError(bool hasError)
  {
    setState(()
    {
      this._hasError = hasError;
    });
  }



  Widget _getWidgetToDisplay()
  {
    if (_isLoading)
    {
      return _loadingIcon;
    }

    else if (_hasError)
    {
      return Text("Error loading exercises");
    }

    else
    {
      if (this._listTileDisplayText.length > 0)
      {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SearchableListView(
            // Text
            _listTileDisplayText,
            textColor: StrydeColors.darkGray,
            textSize: 20,
            searchBarPlaceholderText: "Search exercises...",

            // Border
            borderColor: StrydeColors.darkBlue,
            borderWidth: 2,

            // Miscellaneous
            spaceBetweenTiles: 15,
            onTapListTile: (context, index) =>
                _onTapExerciseListTile(context, index),
            onTapColor: StrydeColors.lightBlue,
          )
        );
      }

      else
      {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              getDefaultPadding(),

              LabelTextElement("No exercises...")
            ],
          )
        );
      }
    }
  }

  void _onTapExerciseListTile(BuildContext context, int index)
  {
    _selectedExercises.add({
      "exercise": _exercises[index],
      "displayText": _listTileDisplayText[index],
    });

    print("\n\n_selectedExercises: " + _selectedExercises.toString());
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: StrydeAppBar.getAppBar("Add Exercise"),
      body: _getWidgetToDisplay()
    );
  }
}
