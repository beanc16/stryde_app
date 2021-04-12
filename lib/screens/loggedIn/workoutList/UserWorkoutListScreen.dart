import 'package:Stryde/components/formHelpers/elements/basic/LabelText.dart';
import 'package:Stryde/controllers/WorkoutController.dart';
import 'package:Stryde/models/Exercise.dart';
import 'package:Stryde/models/MuscleGroup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:Stryde/components/strydeHelpers/widgets/StrydeProgressIndicator.dart';
import 'package:Stryde/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
import 'package:Stryde/components/strydeHelpers/widgets/text/StrydeErrorText.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidget.dart';
import 'package:Stryde/models/Workout.dart';
import 'package:Stryde/screens/loggedIn/workoutList/CreateViewWorkoutScreen.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'package:Stryde/utilities/UiHelpers.dart';
import 'package:Stryde/utilities/HttpQueryHelper.dart';


class UserWorkoutListScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return WorkoutListState();
  }
}



class WorkoutListState extends State<UserWorkoutListScreen> with
    AutomaticKeepAliveClientMixin<UserWorkoutListScreen>
{
  late List<Workout> _workouts;
  late ListView _listView;
  late ToggleableWidget _loadingErrorMsg;

  @override
  void initState()
  {
    super.initState();
    _workouts = [];
    _loadingErrorMsg = _getLoadingErrorMsg();
  }

  ToggleableWidget _getLoadingErrorMsg()
  {
    return ToggleableWidget(
      isLoading: true,
      loadingIndicator: StrydeProgressIndicator(),
      child: StrydeErrorText(displayText: "Error loading workouts"),
    );
  }



  void _fetchWorkouts() async
  {
    _loadingErrorMsg.showLoadingIcon();
    resetWorkouts();

    if (StrydeUserStorage.workouts != null)
    {
      this._workouts = StrydeUserStorage.workouts ?? [];
      _setListView();

      // Hide loading icon & error msg
      _loadingErrorMsg.hideChildAndLoadingIcon();
    }

    else
    {
      WorkoutController.setAll(
        onQuerySuccess: _onGetWorkoutsSuccess,
        onQueryFailureCallback: _onGetWorkoutsFail
      );

      /*
      // Get all workouts created by the current user
      String? id = StrydeUserStorage.userExperience?.id.toString();
      HttpQueryHelper.get(
        "/user/workouts/" + (id ?? ""),
        onSuccess: (response) => _onGetWorkoutsSuccess(response["_results"]),
        onFailure: (response) => _onGetWorkoutsFail(response)
      );
     */
    }
  }

  void _onGetWorkoutsSuccess(List<Workout> workouts)
  {
    this._workouts = workouts;

    // Send models to listview
    _setListView();

    // Hide loading icon & error msg
    _loadingErrorMsg.hideChildAndLoadingIcon();
  }

  void _onGetWorkoutsFail(dynamic results)
  {
    // Show error message
    _loadingErrorMsg.hideLoadingIcon();
    _loadingErrorMsg.showChild();

    //print("_onGetWorkoutsFail:\n" + results.toString());
    print(results);
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
      _listView = ListView.separated(
        shrinkWrap: true,
        //physics: ClampingScrollPhysics(),
        separatorBuilder: (BuildContext context, int index)
        {
          return Padding(
            padding: EdgeInsets.only(bottom: 15),
            );
        },

        itemCount: _workouts.length,
        itemBuilder: (BuildContext context, int index)
        {
          // TODO: Have some kind of converter for nonEmpty workouts
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
        NavigateTo.screen(context, () => CreateViewWorkoutScreen.workout(curWorkout));
      },
    );
  }

  Row _getButtonsAboveListView()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StrydeButton(
          displayText: "Add", textSize: 20, onTap: ()
          {
            NavigateTo.screen(context, () => CreateViewWorkoutScreen());
          },
        ),
      ],
    );
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
      if (this._workouts.length > 0)
      {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              _getButtonsAboveListView(),
              getDefaultPadding(),

              Expanded(
                child: _listView,
              )
            ],
          )
        );
      }

      else
      {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              _getButtonsAboveListView(),
              getDefaultPadding(),

              LabelText("No workouts...")
            ],
          )
        );
      }
    }
  }



  @override
  Widget build(BuildContext context)
  {
    _fetchWorkouts();
    return _getWidgetToDisplay();
  }

  @override
  bool get wantKeepAlive => true;
}