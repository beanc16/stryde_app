import 'package:Stryde/components/toggleableWidget/EmptyWidgetWithData.dart';
import 'package:Stryde/models/ExerciseInformation.dart';
import 'package:Stryde/models/databaseActions/DatabaseActionType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/listViews/ListViewCard.dart';
import 'package:Stryde/components/listViews/ListViewHeader.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/models/Exercise.dart';
import 'package:Stryde/models/Superset.dart';
import 'package:Stryde/models/Workout.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'package:Stryde/models/enums/ExerciseWeightTypeEnum.dart';
import 'package:Stryde/models/enums/ExerciseMuscleTypeEnum.dart';
import 'package:Stryde/models/enums/ExerciseMovementTypeEnum.dart';


class EditWorkoutScreen extends StatefulWidget
{
  final Workout workout;

  EditWorkoutScreen(this.workout);



  @override
  State<StatefulWidget> createState()
  {
    return EditWorkoutState(this.workout);
  }
}



class EditWorkoutState extends State<EditWorkoutScreen>
{
  late List<Widget> listViewWidgets = [];
  final Workout workout;

  EditWorkoutState(this.workout);

  @override
  initState()
  {
    super.initState();

    listViewWidgets = workout.getAsWidgets();

    int index = 0;
    for (Widget widget in listViewWidgets)
    {
      if (widget is ListViewCard || widget is ListViewHeader)
      {
        List<Widget> listViewCards = [];
        if (widget is ListViewHeader)
        {
          int index = listViewWidgets.indexOf(widget);
          for (int i = index + 1; listViewWidgets[i] is ListViewCard; i++)
          {
            listViewCards.add(listViewWidgets[i]);
            if (i + 1 >= listViewWidgets.length)
            {
              break;
            }
          }
        }
        workout.updateDeleteListViewCardFunc(
          () => deleteFromListView(widget),
          index,
          listViewCards
        );
        index++;
      }
    }
  }



  Workout getListViewAsWorkout()
  {
    List<Object> models = [];
    late Superset curSuperset;
    bool inSuperset = false;

    for (int i = 0; i < listViewWidgets.length; i++)
    {
      Widget widget = listViewWidgets[i];

      if (widget is ListViewHeader)
      {
        inSuperset = true;

        curSuperset = Superset(widget.title, [], () => deleteFromListView(widget));
      }

      else if (widget is Divider && inSuperset)
      {
        models.add(curSuperset);
        inSuperset = false;
      }

      else
      {
        if (inSuperset && widget is ListViewCard)
        {
          Exercise exercise = Exercise(
            widget.title,
            widget.description,
            () => deleteFromListView(widget)
          );
          curSuperset.addExercise(exercise);

          if (i + 1 == listViewWidgets.length)
          {
            models.add(curSuperset);
          }
        }

        else if (widget is ListViewCard)
        {
          Exercise exercise = Exercise.model(
            widget.exerciseOrSupersetId,
            widget.title,
            widget.description,
            widget.exerciseWeightType?.value.toStringShort() ?? "",
            widget.exerciseMuscleType?.value.toStringShort() ?? "",
            widget.exerciseMovementType?.value.toStringShort() ?? "",
            widget.muscleGroups,
            onTap: (BuildContext context, dynamic val) => deleteFromListView(widget),
            shouldCreate: widget.shouldCreate,
            information: widget.information
          );
          models.add(exercise);
        }

        // Deleted widget
        else if (widget is EmptyWidgetWithData)
        {
          models.add(widget.data);
        }
      }
    }

    return Workout.notReorderable(
      workout.name, models,
      workoutId: workout.workoutId,
      userId: workout.userId,
      description: workout.description,
    );
  }

  List<Object> getListViewAsExercisesAndSupersets()
  {
    List<Object> models = [];
    Superset curSuperset = Superset.notDeletable("", []); // Same as a null superset
    bool inSuperset = false;

    for (int i = 0; i < listViewWidgets.length; i++)
    {
      Widget widget = listViewWidgets[i];

      if (widget is ListViewHeader)
      {
        inSuperset = true;

        curSuperset = Superset(widget.title, [], () => deleteFromListView(widget));
      }

      else if (widget is Divider && inSuperset)
      {
        models.add(curSuperset);
        inSuperset = false;
      }

      else
      {
        if (inSuperset && widget is ListViewCard)
        {
          Exercise exercise = Exercise(
              widget.title,
              widget.description,
                  () => deleteFromListView(widget)
              );
          curSuperset.addExercise(exercise);

          if (i + 1 == listViewWidgets.length)
          {
            models.add(curSuperset);
          }
        }

        else if (widget is ListViewCard)
        {
          Exercise exercise = Exercise(
              widget.title,
              widget.description,
                  () => deleteFromListView(widget)
              );
          models.add(exercise);
        }
      }
    }

    return models;
  }



  void updateListView(int oldIndex, int newIndex)
  {
    if (newIndex > oldIndex)
    {
      newIndex -= 1;
    }

    final items = listViewWidgets.removeAt(oldIndex);
    listViewWidgets.insert(newIndex, items);

    if (listViewWidgets[newIndex] is ListViewCard)
    {
      updateExerciseIndent(newIndex, listViewWidgets[newIndex]);
    }
  }

  void updateListViewRange(int oldStartIndex, int oldEndIndex, int newStartIndex)
  {
    if (newStartIndex > oldStartIndex)
    {
      newStartIndex -= 1;
    }

    List<Widget> removedWidgets = [];
    // Remove superset header, its exercises, and divider
    for (int numOfItemsRemoved = 0;
         numOfItemsRemoved <= oldEndIndex - oldStartIndex;
         numOfItemsRemoved++)
    {
      Widget item = listViewWidgets.removeAt(oldStartIndex);
      removedWidgets.add(item);
    }

    // Move superset to new location
    listViewWidgets.insertAll(newStartIndex, removedWidgets);
  }

  void updateExerciseIndent(int index, Widget exerciseCard)
  {
    if (exerciseCard is ExerciseListViewCard)
    {
      bool isInSuperset = widgetIsInSuperset(index);

      // In a superset but not indented
      if (isInSuperset && !exerciseCard.isIndented())
      {
        exerciseCard.updateIndent(true);
      }

      // Not in a superset but indented
      else if (!isInSuperset && exerciseCard.isIndented())
      {
        exerciseCard.updateIndent(false);
      }
    }
  }

  void deleteFromListView(Widget listViewCardOrHeader)
  {
    int index = listViewWidgets.indexOf(listViewCardOrHeader);

    if (listViewCardOrHeader is ListViewCard)
    {
      // Mark exercise actiontype as delete
      Object curExercise = this.workout.exercisesAndSupersets[index];
      if (curExercise is Exercise)
      {
        curExercise.setActionAsDelete();
      }

      bool shouldAddWidget = true;
      for (int i = 0; i < listViewCardOrHeader.information.length; i++)
      {
        ExerciseInformation info = listViewCardOrHeader.information[i];

        if (info.databaseActionType == DatabaseActionType.Insert)
        {
          shouldAddWidget = false;
          break;
        }
      }

      if (shouldAddWidget)
      {
        setState(()
        {
          // Save models as deleted
          listViewWidgets.remove(listViewCardOrHeader);
          listViewWidgets.insert(index, EmptyWidgetWithData(data: curExercise));
        });
      }
    }

    // Remove superset header and all exercises within it
    else if (listViewCardOrHeader is ListViewHeader)
    {
      // Remove the header
      setState(()
      {
        listViewWidgets.remove(listViewCardOrHeader);
      });

      // Remove exercise cards within the superset.
      // (Don't change the value of i in for loop. Array size changes
      //  when widget is removed, so no need to update i.)
      for (int i = index; !(listViewWidgets[i] is Divider);)
      {
        setState(()
        {
          listViewWidgets.removeAt(i);
        });
      }

      // Remove divider from end of superset
      setState(()
      {
        listViewWidgets.removeAt(index);
      });
    }
  }

  int getEndIndexOfSuperset(int headerIndex)
  {
    for (int i = headerIndex + 1; i <= listViewWidgets.length; i++)
    {
      if (listViewWidgets[i] is Divider)
      {
        return i;
      }
    }

    return -1;
  }

  bool widgetIsInSuperset(int index)
  {
    // Loop over all widgets before the given widget
    for (int i = index - 1; i >= 0; i--)
    {
      // In superset
      if (listViewWidgets[i] is ListViewHeader)
      {
        return true;
      }

      // Not in superset
      else if (listViewWidgets[i] is Divider)
      {
        return false;
      }
    }

    // Outside of a superset and no supersets before it
    return false;
  }



  void _onReorder(int oldIndex, int newIndex)
  {
    Widget draggedWidget = listViewWidgets[oldIndex];

    if (draggedWidget is ExerciseListViewCard)
    {
      setState(()
      {
        updateListView(oldIndex, newIndex);
      });
    }

    // TODO: Fix reordering entire superset. Sometimes it
    //       works, sometimes it doesn't. It might be having
    //       trouble reordering multiple items based on newIndex?
    else if (draggedWidget is SupersetListViewHeader)
    {
      bool isInSuperset = widgetIsInSuperset(newIndex);

      if (!isInSuperset)
      {
        int dividerIndex = getEndIndexOfSuperset(oldIndex);
        updateListViewRange(oldIndex, dividerIndex, newIndex);
      }
    }
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async
  {
    Workout newWorkout = getListViewAsWorkout();
    newWorkout.isReorderable = false;

    // Send the selected exercises back to the previous screen
    NavigateTo.previousScreenWithData(context, newWorkout);

    // True vs False doesn't matter in this case
    return true;
  }



  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        appBar: StrydeAppBar(titleStr: "Edit Workout Order", context: context),
        body: ReorderableListView(
          children: listViewWidgets,
          scrollDirection: Axis.vertical,

          onReorder: (int oldIndex, int newIndex) =>
                            _onReorder(oldIndex, newIndex)
        )
      ),
    );
  }
}
