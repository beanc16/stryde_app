import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:workout_buddy/components/misc/ListViewCard.dart';
import 'package:workout_buddy/components/misc/ListViewHeader.dart';
import 'package:workout_buddy/components/nav/MyAppBar.dart';
import 'package:workout_buddy/models/Superset.dart';
import 'package:workout_buddy/models/Workout.dart';
import 'package:workout_buddy/models/Exercise.dart';
import 'package:workout_buddy/screens/loggedOut/main.dart';
import 'package:workout_buddy/utilities/NavigatorHelpers.dart';

import 'CreateViewSupersetScreen.dart';
import 'CreateViewWorkoutScreen.dart';


class EditSupersetScreen extends StatefulWidget
{
  final Superset superset;

  EditSupersetScreen(this.superset);



  @override
  State<StatefulWidget> createState()
  {
    return EditSupersetState(this.superset);
  }
}



class EditSupersetState extends State<EditSupersetScreen>
{
  List<Widget> listViewWidgets = [];
  Superset superset;

  EditSupersetState(this.superset);

  @override
  initState()
  {
    super.initState();

    if (superset != null)
    {
      listViewWidgets = superset.getAsWidgets();
    }

    int index = 0;
    for (Widget widget in listViewWidgets)
    {
      if (widget is ListViewCard || widget is ListViewHeader)
      {
        superset.updateDeleteListViewCardFunc(() => deleteFromListView(widget), index);
        index++;
      }
    }
  }



  Superset getListViewAsSuperset()
  {
    List<Exercise> models = [];

    for (int i = 0; i < listViewWidgets.length; i++)
    {
      Widget widget = listViewWidgets[i];

      if (widget is ListViewCard)
      {
        Exercise exercise = Exercise(
          widget.title,
          widget.description,
          () => deleteFromListView(widget)
        );
        models.add(exercise);
      }
    }

    return Superset(superset.name, models, () {});
  }



  void updateListView(int oldIndex, int newIndex)
  {
    if (newIndex > oldIndex)
    {
      newIndex -= 1;
    }

    final items = listViewWidgets.removeAt(oldIndex);
    listViewWidgets.insert(newIndex, items);
  }

  void deleteFromListView(Widget listViewCardOrHeader)
  {
    print("DELETE: " + listViewCardOrHeader.toString());
    if (listViewCardOrHeader is ListViewCard ||
        listViewCardOrHeader is ListViewHeader)
    {
      setState(()
      {
        listViewWidgets.remove(listViewCardOrHeader);
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
                    Superset newSuperset = getListViewAsSuperset();
                    print(newSuperset.toString());

                    // Test if the workout has changed
                    // Save the workout if there has been changes

                    return navigateToScreenWithoutBackUntil(
                      context,
                      () => CreateViewSupersetScreen.superset(newSuperset),
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
        appBar: MyAppBar.getAppBar("Edit Superset"),
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
        })
      ),
    );
  }
}
