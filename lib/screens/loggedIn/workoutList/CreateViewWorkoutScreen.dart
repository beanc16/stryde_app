import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/formHelpers/LabelTextElement.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/nav/MyAppBar.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/models/Workout.dart';
import 'package:workout_buddy/utilities/NavigatorHelpers.dart';
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


  CreateViewWorkoutState()
  {
    workout = Workout.getDemoWorkout(() {});
    _titleInput = LabeledTextInputElement("Title", "Enter title");
    _descriptionInput = LabeledTextInputElement.textArea("Description", "Enter description");
    hasError = false;
  }

  CreateViewWorkoutState.workout(Workout workout)
  {
    this.workout = workout;
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
      //_descriptionInput.inputElement.textEditingController.text = workout.description;
    }
  }



  List<Widget> getChildren()
  {
    workout.isReorderable = false;

    if (!hasError)
    {
      return [
        getPadding(10),

        this._titleInput,
        getPadding(15),

        this._descriptionInput,
        getPadding(15),

        // Exercise & Superset widget
        this._getListViewHeader(),
        workout.getAsListView(),
        getDefaultPadding(),
      ];
    }

    else
    {
      return [
        getPadding(10),

        this._titleInput,
        getPadding(15),

        this._descriptionInput,
        getPadding(15),

        // Exercise & Superset widgets
        this._getListViewHeader(),
        workout.getAsListView(),
        getDefaultPadding(),
      ];
    }
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
                        print("Add an exercise");
                        //workout.isReorderable = true;
                        //navigateToScreen(context, () => EditWorkoutScreen(workout));
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
                      child: getRaisedButton("Edit", 14, ()
                      {
                        workout.isReorderable = true;
                        navigateToScreen(context, () => EditWorkoutScreen(workout));
                      }),
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