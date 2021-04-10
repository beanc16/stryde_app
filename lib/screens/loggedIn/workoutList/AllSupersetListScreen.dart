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
import 'package:Stryde/models/Superset.dart';
import 'package:Stryde/utilities/HttpQueryHelper.dart';
import 'package:Stryde/utilities/NavigateTo.dart';


class AllSupersetListScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return AllSupersetListScreenState();
  }
}



class AllSupersetListScreenState extends State<AllSupersetListScreen>
{
  late List<Superset> _supersets;
  late List<String> _listTileDisplayText;
  late ToggleableWidget _loadingErrorMsg;
  late List<Superset> _selectedSupersets;
  late StrydeMultiTagDisplay _selectSupersetsTagDisplay;

  @override
  void initState()
  {
    super.initState();

    _loadingErrorMsg = _getLoadingErrorMsg();
    _supersets = [];
    _listTileDisplayText = [];
    _selectedSupersets = [];
    _selectSupersetsTagDisplay = StrydeMultiTagDisplay(
      displayText: [],
      onDeleteTag: (int index, String displayStr) =>
                          _onDeselectSupersetTag(index, displayStr),
    );

    // Get exercises after build method is called
    /*
    WidgetsBinding.instance.addPostFrameCallback((timestamp) =>
                                                    _fetchSupersets());
    */
  }

  ToggleableWidget _getLoadingErrorMsg()
  {
    return ToggleableWidget(
      isLoading: true,
      loadingIndicator: StrydeProgressIndicator(),
      child: StrydeErrorText(displayText: "Error loading supersets"),
    );
  }



  void _fetchSupersets() async
  {
    _loadingErrorMsg.showLoadingIcon();

    if (StrydeUserStorage.supersets != null)
    {
      this._supersets = StrydeUserStorage.supersets ?? [];

      // Convert _supersets to _listTileDisplayText
      setState(()
      {
        _listTileDisplayText = _supersets.map((e) => e.name).toList();
      });

      // Hide loading icon & error msg
      _loadingErrorMsg.hideChildAndLoadingIcon();
    }

    else
    {
      // Get all supersets owned by the user
      HttpQueryHelper.get(
        "/user/supersets/",
        onSuccess: (dynamic response) => _onGetSupersetsSuccess(response),
        onFailure: (dynamic response) => _onGetSupersetsFail(response)
      );
    }
  }

  void _onGetSupersetsSuccess(Map<String, dynamic> supersetsJson)
  {
    print("supersetsJson: " + supersetsJson.toString());

    // Convert exercises to model
    _convertSupersetResults(supersetsJson["_results"]);

    // Save to session-long storage
    StrydeUserStorage.supersets = this._supersets;

    // Convert _exercises to _listTileDisplayText
    setState(()
    {
      _listTileDisplayText = _supersets.map((e) => e.name).toList();
    });

    // Hide loading icon & error msg
    _loadingErrorMsg.hideChildAndLoadingIcon();
  }

  void _onGetSupersetsFail(dynamic results)
  {
    // Show error message
    _loadingErrorMsg.hideLoadingIcon();
    _loadingErrorMsg.showChild();

    print("_onGetSupersetsFail:\n" + results.toString());
  }

  void _convertSupersetResults(List<dynamic> supersetList)
  {
    for (int i = 0; i < supersetList.length; i++)
    {
      // Helper variables
      Map<String, dynamic> superset = supersetList[i];
      List<dynamic> exercises = superset["mgInfo"];

      // Convert the current superset's exercises into models
      List<Exercise> supExercises = [];
      for (int i = 0; i < exercises.length; i++)
      {
        // Convert the current exercise's muscle groups into models
        List<dynamic> muscleGroupInfo = exercises[i]["mgInfo"];
        List<MuscleGroup> muscleGroups = [];
        for (int i = 0; i < muscleGroupInfo.length; i++)
        {
          MuscleGroup mg = MuscleGroup(muscleGroupInfo[i]["mgName"]);
          muscleGroups.add(mg);
        }

        Exercise ex = Exercise.model(
          exercises[i]["exerciseId"], exercises[i]["exerciseName"],
          exercises[i]["exerciseDescription"],
          exercises[i]["exerciseWeightTypeName"],
          exercises[i]["exerciseMuscleTypeName"],
          exercises[i]["exerciseMovementTypeName"], muscleGroups
        );
        supExercises.add(ex);
      }

      // Convert exercise info to a model and add it to _exercises
      Superset sup = Superset.notDeletable(
        superset["supersetName"], supExercises
      );

      setState(()
      {
        this._supersets.add(sup);
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
          child: _loadingErrorMsg,
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
                                  _onTapSupersetListTile(context, index),
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
                      child: _selectSupersetsTagDisplay,
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
          child: LabelText("No supersets..."),
        );
      }
    }
  }



  void _onTapSupersetListTile(BuildContext context, int index)
  {
    _selectedSupersets.add(_supersets[index]);

    setState(()
    {
      _selectSupersetsTagDisplay.addTag(_listTileDisplayText[index]);
    });
  }

  void _onDeselectSupersetTag(int index, String displayStr)
  {
    setState(()
    {
      _selectedSupersets.removeAt(index);
    });
  }



  Future<bool> _onBackButtonPressed(BuildContext context) async
  {
    // Send the selected exercises back to the previous screen
    NavigateTo.previousScreenWithData(context, _selectedSupersets);

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
        appBar: StrydeAppBar(titleStr: "Add Superset"),
        body: _getWidgetToDisplay()
      ),
       */
    );
  }
}
