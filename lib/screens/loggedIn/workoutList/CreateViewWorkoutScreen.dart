import 'dart:convert';
import 'package:Stryde/components/formHelpers/elements/basic/LabelText.dart';
import 'package:Stryde/components/formHelpers/elements/text/LabeledTextInputElement.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooLongException.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooShortException.dart';
import 'package:Stryde/components/listViews/ListViewCard.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:Stryde/utilities/HttpQueryHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/widgets/StrydeProgressIndicator.dart';
import 'package:Stryde/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/components/willPopScope/WillPopScopeSaveDontSave.dart';
import 'package:Stryde/models/Workout.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'package:Stryde/utilities/UiHelpers.dart';
import 'package:Stryde/screens/loggedIn/workoutList/EditWorkoutScreen.dart';
import 'AllExerciseAndSupersetListScreen.dart';
import 'AllExerciseListScreen.dart';


class CreateViewWorkoutScreen extends StatefulWidget
{
  Workout? workout;
  List<Workout> workoutList;

  CreateViewWorkoutScreen(this.workoutList);
  CreateViewWorkoutScreen.workout(this.workout, this.workoutList);



  @override
  State<StatefulWidget> createState()
  {
    if (this.workout != null)
    {
      return CreateViewWorkoutState.workout(this.workout!, this.workoutList);
    }

    else
    {
      return CreateViewWorkoutState(this.workoutList);
    }
  }
}



class CreateViewWorkoutState extends State<CreateViewWorkoutScreen>
{
  late Workout workout;
  List<Workout> workoutList;
  late final LabeledTextInputElement _titleInput;
  late final LabeledTextInputElement _descriptionInput;
  late List<dynamic> _listViewElements;
  late bool _hasChanged;
  late bool _isNewWorkout;


  CreateViewWorkoutState(List<Workout> workoutList) :
    this.workout(Workout.notReorderable("", []), workoutList, isNewWorkout: true);

  CreateViewWorkoutState.workout(this.workout, this.workoutList,
                                 {bool isNewWorkout = false})
  {
    print("workout.exercisesAndSupersets (constructor): " +
              workout.exercisesAndSupersets.toString());
    _listViewElements = workout.getAsWidgets();
    _hasChanged = false;
    this._isNewWorkout = isNewWorkout;

    _titleInput = LabeledTextInputElement(
      labelText: "Title",
      placeholderText: "Enter title",
      minInputLength: 1,
      maxInputLength: 45,
    );
    _descriptionInput = LabeledTextInputElement.textArea(
      labelText: "Description",
      placeholderText: "Enter description",
      maxInputLength: 1000,
    );
  }

  @override
  initState()
  {
    if (workout != null)
    {
      _titleInput.inputText = workout.name;
      _descriptionInput.inputText = workout.description;
    }
  }



  bool _isInputValid()
  {
    bool result = true;

    if (_titleInput.isValidInput())
    {
      _titleInput.showBorder = false;
    }
    else
    {
      _titleInput.showBorder = true;
      result = false;
    }

    if (_descriptionInput.isValidInput())
    {
      _descriptionInput.showBorder = false;
    }
    else
    {
      _descriptionInput.showBorder = true;
      result = false;
    }

    return result;
  }

  void _tryThrowExceptions()
  {
    try
    {
      _titleInput.tryThrowExceptionMessage();
      _descriptionInput.tryThrowExceptionMessage();
    }

    on InputTooLongException catch (ex)
    {
      // TODO: Do someone on too long error
    }

    on InputTooShortException catch (ex)
    {
      // TODO: Do someone on too short error
    }

    on Exception catch (ex)
    {
      // TODO: Do someone on general error
    }
  }



  List<Widget> getChildren()
  {
    List<Widget> children = [
      getPadding(10),

      this._titleInput,

      Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: this._descriptionInput,
      ),

      // Exercise & Superset widget
      this._getListViewHeader(),
    ];
    workout.isReorderable = false;

    // Workout exists and has an exercises(s) and/or a superset(s)
    if (!workout.hasNoExercisesOrSupersets())
    {
      children.addAll([
        Flexible(
          child: ListView.builder(
            itemCount: _listViewElements.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),  // Lets parent handle scrolling
            itemBuilder: (BuildContext context, int index)
            {
              dynamic curElement = _listViewElements[index];
              if (curElement is ListViewCard)
              {
                curElement.isReorderable = false;
              }

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
                child: LabelText("No exercises..."),
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
                child: LabelText("Exercises"),
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
    if (workout.hasNoExercisesOrSupersets())
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
    List<Object> exercisesToAdd = await NavigateTo.screenReturnsData(
      context, () => AllExerciseListScreen()
      //context, () => AllExerciseAndSupersetListScreen()
    );

    if (exercisesToAdd.length > 0)
    {
      _hasChanged = true;

      setState(()
      {
        workout.addExercisesOrSupersets(exercisesToAdd);
        _listViewElements = workout.getAsWidgets();
      });
    }
  }

  void _onTapEditButton() async
  {
    workout.isReorderable = true;
    Workout newWorkout = await NavigateTo.screenReturnsData(
      context, () => EditWorkoutScreen(workout)
    );

    if (workout != newWorkout)
    {
      if (workout.exercisesAndSupersets != newWorkout.exercisesAndSupersets)
      {
        _hasChanged = true;
      }

      workout = newWorkout;
      _updateListView();
    }
  }

  void _updateListView()
  {
    setState(()
    {
      workout.isReorderable = false;
      _listViewElements = workout.getAsWidgets();
    });
  }



  String _getAppBarTitle()
  {
    if (workout.name.length > 0)
    {
      return "Edit Workout";
    }

    else
    {
      return "Create Workout";
    }
  }

  void _updateWorkoutNameAndDesc()
  {
    workout.name = _titleInput.inputText;
    workout.description = _descriptionInput.inputText;
  }

  void _saveWorkout(BuildContext context)
  {
    _updateWorkoutNameAndDesc();
    print("workout.exercisesAndSupersets: " + workout.exercisesAndSupersets.toString());
    Map<String, String> postData = workout.getAsJson();
    
    String route = "/user";
    if (!_isNewWorkout)
    {
      route += "/update";
    }
    else
    {
      route += "/create";
    }
    route += "/workout";

    print("postData: " + postData.toString());
    print("workout.exercisesAndSupersets: " + workout.exercisesAndSupersets.toString());

    HttpQueryHelper.post(
      route,
      postData,
      onSuccess: (jsonResult)
      {
        print("jsonResult: " + jsonResult.toString());

        // Updated existing workout
        if (!_isNewWorkout)
        {
          int index = workoutList.indexWhere((w) =>
                                    w.workoutId == workout.workoutId);
          workoutList[index] = workout;
        }
        // Created new workout
        else
        {
          workoutList.add(workout);
        }

        StrydeUserStorage.workouts = workoutList;
        NavigateTo.previousScreens(context, 2);
      },
      onFailure: (response)
      {
        print("Fail: " + response.toString());
      },
    );
  }

  Future<dynamic> _onSave(BuildContext context)
  {
    _saveWorkout(context);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
        return Dialog(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              getDefaultPadding(),

              StrydeProgressIndicator(),
              getDefaultPadding(),

              Text(
                "Saving...",
                style: TextStyle(
                  color: StrydeColors.darkGray
                ),
              ),
              getDefaultPadding(),
            ],
          )
        );
      }
    );
  }



  @override
  Widget build(BuildContext context)
  {
    /*
    workout.updateOnTapFunc((BuildContext context, dynamic exercise)
    {
      NavigateTo.screen(
        context,
        () => EditExerciseInformationScreen(exercise)
      );
    });
    */

    return WillPopScopeSaveDontSave(
      onSave: (BuildContext context) => _onSave(context),
      showPopupMenuIf: () => _hasChanged,
      child: Scaffold(
        appBar: StrydeAppBar(titleStr: _getAppBarTitle(), context: context),
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
      )
    );
  }
}