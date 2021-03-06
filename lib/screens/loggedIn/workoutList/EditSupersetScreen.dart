import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Stryde/components/listViews/ListViewCard.dart';
import 'package:Stryde/components/listViews/ListViewHeader.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/models/Superset.dart';
import 'package:Stryde/models/Exercise.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'CreateViewSupersetScreen.dart';
import 'package:Stryde/models/enums/ExerciseWeightTypeEnum.dart';
import 'package:Stryde/models/enums/ExerciseMuscleTypeEnum.dart';
import 'package:Stryde/models/enums/ExerciseMovementTypeEnum.dart';


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
        Exercise exercise = Exercise.model(
          widget.exerciseOrSupersetId,
          widget.title,
          widget.description,
          widget.exerciseWeightType?.value.toStringShort() ?? "",
          widget.exerciseMuscleType?.value.toStringShort() ?? "",
          widget.exerciseMovementType?.value.toStringShort() ?? "",
          widget.muscleGroups,
          onTap: widget.onTap,
          shouldDelete: widget.shouldDelete,
          shouldCreate: widget.shouldCreate,
          information: widget.information,
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

                    return NavigateTo.screenAfterPopping(
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
        appBar: StrydeAppBar(titleStr: "Edit Superset"),
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
