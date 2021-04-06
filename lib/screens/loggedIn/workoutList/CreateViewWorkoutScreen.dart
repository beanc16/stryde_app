import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/formHelpers/LabelTextElement.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/models/Exercise.dart';
import 'package:workout_buddy/models/Workout.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/AllExerciseListScreen.dart';
import 'package:workout_buddy/utilities/NavigateTo.dart';
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
  List<dynamic> _listViewElements;


  CreateViewWorkoutState()
  {
    workout = Workout.notReorderable("", []);
    _listViewElements = workout.getAsWidgets();

    _titleInput = LabeledTextInputElement("Title", "Enter title");
    _descriptionInput = LabeledTextInputElement.textArea(
      "Description",
      "Enter description"
    );
  }

  CreateViewWorkoutState.workout(Workout workout)
  {
    this.workout = workout;
    _listViewElements = workout.getAsWidgets();

    _titleInput = LabeledTextInputElement("Title", "Enter title");
    _descriptionInput = LabeledTextInputElement.textArea(
      "Description",
      "Enter description"
    );
  }

  @override
  initState()
  {
    if (workout != null)
    {
      _titleInput.inputElement.textEditingController.text =
          workout.name;
      _descriptionInput.inputElement.textEditingController.text =
          workout.description;
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

      // Exercise & Superset widget
      this._getListViewHeader(),
    ];

    if (workout != null)
    {
      workout.isReorderable = false;
    }

    // Workout exists and has an exercises(s) and/or a superset(s)
    if (workout != null && !workout.hasNoExercisesOrSupersets())
    {
      children.addAll([
        Flexible(
          child: ListView.builder(
            itemCount: _listViewElements.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),  // Lets parent handle scrolling
            itemBuilder: (BuildContext context, int index)
            {
              return _listViewElements[index];
            }
          ),
        ),
        getDefaultPadding(),
      ]);
    }

    // Workout doesn't exist or it has no exercises or supersets
    else
    {
      children.addAll([
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 4, top: 10),
                child: LabelTextElement("No exercises..."),
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
                padding: EdgeInsets.only(left: 3),
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
                padding: EdgeInsets.only(right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 2,
                      child: StrydeButton(
                        displayText: "Add",
                        textSize: 14,
                        onTap: () => _onTapAddButton(),
                      ),
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
      return StrydeButton(
        displayText: "Edit", textSize: 14, onTap: null
      );
    }

    // Enable the button if there IS exercises or supersets
    else
    {
      return StrydeButton(
        displayText: "Edit",
        textSize: 14,
        onTap: () => _onTapEditButton()
      );
    }
  }

  void _onTapAddButton() async
  {
    List<dynamic> exercisesToAdd = await NavigateTo.screenReturnsData(
      context, () => AllExerciseListScreen()
    );

    if (exercisesToAdd != null && exercisesToAdd.length > 0)
    {
      setState(()
      {
        workout.addExercisesOrSupersets(exercisesToAdd);
        // TODO: Delete one line of code below
        //_listViewElements.addAll(workout.getAsWidgets());
        _listViewElements = workout.getAsWidgets();
      });
    }
  }

  void _onTapEditButton() async
  {
    workout.isReorderable = true;
    //NavigateTo.screen(context, () => EditWorkoutScreen(workout));

    Workout newWorkout = await NavigateTo.screenReturnsData(
      context, () => EditWorkoutScreen(workout)
    );
    print("newWorkout:\n" + newWorkout.toString());

    workout = newWorkout;
    _updateListView();
  }

  void _updateListView()
  {
    setState(()
    {
      _listViewElements = workout.getAsWidgets();
    });
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: StrydeAppBar(titleStr: "View Workout"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: getChildren(),
          )
        )
      ),
    );
  }
}