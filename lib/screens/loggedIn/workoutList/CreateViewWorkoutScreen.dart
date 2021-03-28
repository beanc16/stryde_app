import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/formHelpers/LabelTextElement.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/nav/MyAppBar.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/models/Workout.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/AllExerciseListScreen.dart';
import 'package:workout_buddy/utilities/NavigatorHelpers.dart';
import 'package:workout_buddy/utilities/TextHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/EditWorkoutScreen.dart';


class CreateViewWorkoutScreen extends StatefulWidget
{
  Workout workout;

  CreateViewWorkoutScreen();
  CreateViewWorkoutScreen.workout(this.workout);



  @override
  State<StatefulWidget> createState()
  {
    if (this.workout != null)
    {
      return CreateViewWorkoutState.workout(this.workout);
    }

    else
    {
      return CreateViewWorkoutState();
    }
  }
}



class CreateViewWorkoutState extends State<CreateViewWorkoutScreen>
{
  Workout workout;
  LabeledTextInputElement _titleInput;
  LabeledTextInputElement _descriptionInput;
  bool hasError;
  bool _makingNewWorkout;


  CreateViewWorkoutState()
  {
    workout = null;
    _makingNewWorkout = true;
    _titleInput = LabeledTextInputElement("Title", "Enter title");
    _descriptionInput = LabeledTextInputElement.textArea("Description", "Enter description");
    hasError = false;
  }

  CreateViewWorkoutState.workout(Workout workout)
  {
    this.workout = workout;
    _makingNewWorkout = false;
    _titleInput = LabeledTextInputElement("Title", "Enter title");
    _descriptionInput = LabeledTextInputElement.textArea("Description", "Enter description");
    hasError = false;
  }

  @override
  initState()
  {
    hasError = false;

    if (workout != null)
    {
      _titleInput.inputElement.textEditingController.text = workout.name;
      _descriptionInput.inputElement.textEditingController.text = workout.description;
    }
  }



  List<Widget> getChildren()
  {
    List<Widget> children = [
      getPadding(10),

      this._titleInput,
      getPadding(15),

      this._descriptionInput,
      getPadding(15),
    ];

    if (workout != null)
    {
      workout.isReorderable = false;
    }

    // There's no errors & workout has an exercises(s) and/or superset(s)
    if (!hasError && workout != null && !workout.hasNoExercisesOrSupersets())
    {
      children.addAll([
        // Exercise & Superset widget
        this._getListViewHeader(),

        workout.getAsListView(),
        getDefaultPadding(),
      ]);
    }

    // There's no errors and workout doesn't exist or it has no exercises or supersets
    else if (!hasError)
    {
      children.addAll([
        // Exercise & Superset widget
        this._getListViewHeader(),

        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: LabelTextElement("No exercises..."),
              )
            ),
          ],
        ),
        getDefaultPadding(),
      ]);
    }

    // Error
    else
    {
      children.addAll([
        Row(
          children: [
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextHeader2("Error loading workout"),
                )
            ),
          ],
        ),
        getDefaultPadding(),
      ]);
    }

    return children;
  }

  Row _getListViewHeader()
  {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: LabelTextElement("Exercises"),
              )
            ],
          )
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 2,
                      child: getRaisedButton("Add", 14, ()
                      {
                        navigateToScreen(context, () => AllExerciseListScreen());
                      }),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: _getEditButton(),
                    ),
                  ],
                ),
              )
            ],
          )
        ),
      ],
    );
  }

  Widget _getEditButton()
  {
    // Disable the button if there IS NO exercises or supersets
    if (workout == null || workout.hasNoExercisesOrSupersets())
    {
      return getRaisedButton("Edit", 14, null);
    }

    // Enable the button if there IS exercises or supersets
    else
    {
      return getRaisedButton("Edit", 14, ()
      {
        workout.isReorderable = true;
        navigateToScreen(context, () => EditWorkoutScreen(workout));
      });
    }
  }



  @override
  Widget build(BuildContext context)
  {
    double padding = 5;

    return Scaffold(
      appBar: MyAppBar.getAppBar("View Workout"),
      body: Padding(
        padding: EdgeInsets.only(
          left: padding,
          right: padding,
        ),

        child: SinglePageScrollingWidget(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: getChildren(),
          )
        ),
      )
    );
  }
}