import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/listViews/ListViewCard.dart';
import 'package:workout_buddy/components/listViews/ListViewHeader.dart';
import 'package:workout_buddy/components/nav/StrydeAppBar.dart';
import 'package:workout_buddy/models/Exercise.dart';
import 'package:workout_buddy/models/Superset.dart';
import 'package:workout_buddy/models/Workout.dart';
import 'package:workout_buddy/utilities/NavigateTo.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/CreateViewWorkoutScreen.dart';


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
  List<Widget> listViewWidgets = [];
  Workout workout;

  EditWorkoutState(this.workout);

  @override
  initState()
  {
    super.initState();

    if (workout != null)
    {
      listViewWidgets = workout.getAsWidgets();
    }

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
    Superset curSuperset = null;
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

    return Workout(workout.name, models);
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
      print(item);
      removedWidgets.add(item);
    }

    // Move superset to new location
    print(removedWidgets);
    listViewWidgets.insertAll(newStartIndex, removedWidgets);
  }

  void updateExerciseIndent(int index, ExerciseListViewCard exerciseCard)
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

  int getEndIndexOfSuperset(int headerIndex)
  {
    for (int i = headerIndex + 1; i <= listViewWidgets.length; i++)
    {
      if (listViewWidgets[i] is Divider)
      {
        return i;
      }
    }

    return null;
  }

  void deleteFromListView(Widget listViewCardOrHeader)
  {
    if (listViewCardOrHeader is ListViewCard)
    {
      setState(()
      {
        listViewWidgets.remove(listViewCardOrHeader);
      });
    }

    // Remove superset header and all exercises within it
    else if (listViewCardOrHeader is ListViewHeader)
    {
      // Remove the header
      int index = listViewWidgets.indexOf(listViewCardOrHeader);
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

  Future<bool> _onBackButtonPressed() async
  {
      return (
        await showDialog(
          context: context,
          builder: (context)
          {
            return AlertDialog(
              content: Text("Would you like to save your changes?"),
              actions: <Widget>[
                FlatButton(
                  onPressed: (()
                  {
                    return Navigator.of(context).pop(false);
                  }),
                  child: Text("Keep Editing"),
                ),
                FlatButton(
                  onPressed: (()
                  {
                    return Navigator.of(context).pop(true);
                  }),
                  child: Text("Don't Save"),
                ),
                FlatButton(
                  onPressed: (()
                  {
                    Workout newWorkout = getListViewAsWorkout();
                    print(newWorkout.toString());

                    // TODO: Test if the workout has changed
                    // TODO: Save the workout if there has been changes

                    return NavigateTo.screenWithoutBackUntil(
                      context,
                      () => CreateViewWorkoutScreen.workout(newWorkout),
                      2
                    );
                  }),
                  child: Text("Save"),
                ),
              ],
            );
          }
        )
      ) ?? false;
  }



  @override
  Widget build(BuildContext context)
  {
    return new WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        appBar: StrydeAppBar.getAppBar("Edit Workout"),
        body: ReorderableListView(
        children: listViewWidgets,

        scrollDirection: Axis.vertical,
        onReorder: (int oldIndex, int newIndex)
        {
          Widget draggedWidget = listViewWidgets[oldIndex];

          if (draggedWidget is ExerciseListViewCard)
          {
            setState(()
            {
              updateListView(oldIndex, newIndex);
            });
          }

          // TODO: Fix reordering entire superset. Sometimes it...
          //       works, sometimes it doesn't. It might be having...
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
        })
      ),
    );
  }
}
