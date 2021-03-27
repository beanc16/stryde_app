import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/WorkoutListScreen.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';

import 'SupersetListScreen.dart';

class WorkoutAndSupersetListScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return WorkoutAndSupersetListState();
  }
}



class WorkoutAndSupersetListState extends State<WorkoutAndSupersetListScreen>
{
  WorkoutAndSupersetListEnum _screenToDisplayEnum;
  List<Widget> _screens;

  @override
  void initState()
  {
    _screenToDisplayEnum = WorkoutAndSupersetListEnum.WORKOUT_LIST;

    _screens = [
      WorkoutListScreen(),
      SupersetListScreen()
    ];
  }

  void _updateScreenToDisplay(WorkoutAndSupersetListEnum screenEnum)
  {
    setState(()
    {
      _screenToDisplayEnum = screenEnum;
    });
  }



  Widget _getScreenToDisplay()
  {
    if (_screenToDisplayEnum == WorkoutAndSupersetListEnum
                                        .WORKOUT_LIST)
    {
      return _screens[WorkoutAndSupersetListEnum.WORKOUT_LIST.index];
    }

    else if (_screenToDisplayEnum == WorkoutAndSupersetListEnum
                                        .SUPERSET_LIST)
    {
      return _screens[WorkoutAndSupersetListEnum.SUPERSET_LIST.index];
    }
  }

  Row _getTopNavBar()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: FlatButton(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Workouts",
                style: TextStyle(
                  fontSize: 20,
                  color: _getWorkoutButtonColor()
                ),
              )
            ),

            color: Colors.white,
            onPressed: ()
            {
              _updateScreenToDisplay(WorkoutAndSupersetListEnum
                                         .WORKOUT_LIST);
            },
          )
        ),

        Expanded(
          child:FlatButton(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Supersets",
                style: TextStyle(
                  fontSize: 20,
                  color: _getSupersetButtonColor()
                ),
              )
            ),

            color: Colors.white,
            onPressed: ()
            {
              _updateScreenToDisplay(WorkoutAndSupersetListEnum
                                         .SUPERSET_LIST);
            },
          ),
        ),
      ],
    );
  }

  Color _getWorkoutButtonColor()
  {
    if (_screenToDisplayEnum == WorkoutAndSupersetListEnum
        .WORKOUT_LIST)
    {
      return StrydeColors.lightBlue;
    }

    else if (_screenToDisplayEnum == WorkoutAndSupersetListEnum
        .SUPERSET_LIST)
    {
      return StrydeColors.darkGray;
    }
  }

  Color _getSupersetButtonColor()
  {
    if (_screenToDisplayEnum == WorkoutAndSupersetListEnum
        .WORKOUT_LIST)
    {
      return StrydeColors.darkGray;
    }

    else if (_screenToDisplayEnum == WorkoutAndSupersetListEnum
        .SUPERSET_LIST)
    {
      return StrydeColors.lightBlue;
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [
        // Top NavBar
        Container(
          child: _getTopNavBar(),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                //spreadRadius: 5,
                blurRadius: 1,
                offset: Offset(0, 0)
              )
            ]
          ),
        ),

        getDefaultPadding(),
        Flexible(
          child: _getScreenToDisplay(),
        ),
      ],
    );
  }
}



enum WorkoutAndSupersetListEnum
{
  WORKOUT_LIST,
  SUPERSET_LIST
}