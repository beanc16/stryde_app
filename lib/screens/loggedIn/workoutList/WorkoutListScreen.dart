import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:workout_buddy/components/formHelpers/LabelTextElement.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:workout_buddy/components/strydeHelpers/StrydeUserStorage.dart';
import 'package:workout_buddy/models/Workout.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/CreateViewWorkoutScreen.dart';
import 'package:workout_buddy/utilities/NavigatorHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';
import 'package:workout_buddy/utilities/httpQueryHelpers.dart';


class WorkoutListScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return WorkoutListState();
  }
}



class WorkoutListState extends State<WorkoutListScreen>
{
  List<Workout> _workouts;
  bool _isLoading;
  bool _hasError;
  Center _loadingIcon;
  ListView _listView;

  @override
  void initState()
  {
    _isLoading = false;
    _hasError = false;
    _workouts = [];

    _loadingIcon = getCircularProgressIndicatorCentered();

    _fetchWorkouts();
  }

  void _fetchWorkouts() async
  {
    setIsLoading(true);
    resetWorkouts();

    if (StrydeUserStorage.workouts != null)
    {
      //_workouts = StrydeUserStorage.workouts;
      //_setListView();
    }

    else
    {
      // Get all workouts created by the current user
      HttpQueryHelper.get(
        "/user/workouts/" + StrydeUserStorage.userExperience
            .id.toString(),
        onSuccess: (dynamic response) => _onGetWorkoutsSuccess(response["_results"]),
        onFailure: (dynamic response) => _onGetWorkoutsFail(response)
      );
    }
  }

  void _onGetWorkoutsSuccess(Map<String, dynamic> workoutsJson)
  {
    // TODO: Convert workouts to model
    print(workoutsJson);
    _convertWorkoutResults(
        workoutsJson["nonEmptyWorkoutResults"]["_results"],
        workoutsJson["emptyWorkoutResults"]["_results"]
    );

    // TODO: Set StrydeUserStorage.workouts
    //StrydeUserStorage.workouts = this._workouts;

    // Send models to listview
    _setListView();

    setIsLoading(false);
    setHasError(false);
  }

  void _onGetWorkoutsFail(dynamic results)
  {
    print("_onGetWorkoutsFail:\n" + results.toString());

    setIsLoading(false);
    setHasError(true);
  }

  void _convertWorkoutResults(List<dynamic> nonEmptyWorkouts,
                              List<dynamic> emptyWorkouts)
  {
    // TODO: Convert nonEmptyWorkouts
    // ^ do here

    // Convert emptyWorkouts
    for (int i = 0; i < emptyWorkouts.length; i++)
    {
      Map<String, dynamic> workout = emptyWorkouts[i];

      setState(()
      {
        this._workouts.add(Workout(
          workout["name"], [], description: workout["description"],
          userId: workout["userId"], workoutId: workout["workoutId"]
        ));
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

  void resetWorkouts()
  {
    setState(()
    {
      this._workouts = [];
    });
  }



  void _setListView()
  {
    setState(()
    {
      _listView = ListView.builder(
        shrinkWrap: true,
        itemCount: _workouts.length,
        itemBuilder: (BuildContext context, int index)
        {
          // TODO: Have some kind of converter for nonEmpty workouts
          //return _getWorkoutListTile(context, _workouts[index]);
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(
                width: 2,
                color: StrydeColors.darkBlue
              )
            ),
            child: _getWorkoutListTile(context, _workouts[index]),
          );
        },
      );
    });
  }
  ListTile _getWorkoutListTile(BuildContext context, Workout curWorkout)
  {
    return ListTile(
      contentPadding: EdgeInsets.all(5),
      //tileColor: StrydeColors.lightGray,
      title: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Text(
          curWorkout.name,
          style: TextStyle(
            color: StrydeColors.darkGray,
            fontSize: 20
          ),
        )
      ),

      onTap: ()
      {
        navigateToScreen(context, () => CreateViewWorkoutScreen.workout(curWorkout));
      },
    );
  }

  Row _getButtonsAboveListView()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getRaisedButton("Add", 20, ()
        {
          navigateToScreen(context, () => CreateViewWorkoutScreen());
        },
        buttonColor: StrydeColors.purple,
        textColor: Colors.white)
      ],
    );
  }

  Widget _getWidgetToDisplay()
  {
    if (_isLoading)
    {
      return _loadingIcon;
    }

    else if (_hasError)
    {
      return Text("Error loading workouts");
    }

    else
    {
      if (this._workouts.length > 0)
      {
        return Column(
          children: [
            _getButtonsAboveListView(),
            getDefaultPadding(),

            Expanded(
              child: _listView,
            )
          ],
        );
      }

      else
      {
        return Column(
          children: [
            _getButtonsAboveListView(),
            getDefaultPadding(),

            LabelTextElement("No workouts...")
          ],
        );
      }
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return _getWidgetToDisplay();
  }
}