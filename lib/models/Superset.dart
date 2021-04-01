import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/listViews/ListViewHeader.dart';
import 'package:workout_buddy/models/Exercise.dart';



class Superset
{
  final String name;
  List<Exercise> exercises;
  SupersetListViewHeader listViewHeader;
  bool isReorderable = true;

  Superset(this.name, this.exercises,
           Function() onDeleteListViewHeader)
  {
    this.listViewHeader = SupersetListViewHeader(
      this.name,
      Key("${this.name}"),
      true,
      onDeleteListViewHeader
    );
  }

  Superset.notDeletable(this.name, this.exercises)
  {
    this.listViewHeader = SupersetListViewHeader.notDeletable(
      this.name,
      Key("${this.name}")
    );

    this.isReorderable = false;
  }

  void addExercise(Exercise exercise)
  {
    this.exercises.add(exercise);
  }

  @override
  String toString()
  {
    String exercisesStr = exercises.toString();
    return 'Superset{name: $name, exercises: $exercisesStr}';
  }



  List<Widget> getAsWidgets()
  {
    List<Widget> children = [];

    for (int i = 0; i < exercises.length; i++)
    {
      Exercise curExercise = exercises[i];

      ExerciseListViewCard elvc = curExercise.exerciseListViewCard;
      elvc.setIsReorderable(this.isReorderable);
      children.add(elvc);
    }

    if (children.length <= 0)
    {
      children.add(
        Text(
          "No Exercises",
          key: Key("No Exercises"),
        )
      );
    }

    return children;
  }

  ListView getAsListView()
  {
    List<Widget> exerciseListViewCards = this.getAsWidgets();

    return ListView(
      key: Key(this.name),
      children: exerciseListViewCards,
      shrinkWrap: true,
    );
  }



  void updateDeleteListViewCardFunc(Function() onDeleteListViewCard,
                                    int index)
  {
    if (index >= exercises.length)
    {
      return;
    }

    for (int i = 0; i < exercises.length; i++)
    {
      if (i == index)
      {
        _updateDeleteFunc(exercises[i], onDeleteListViewCard);
      }
    }
  }

  void _updateDeleteFunc(Exercise exercise,
                         Function() onDeleteListViewCard)
  {
    ExerciseListViewCard exerciseListViewCard =
        exercise.exerciseListViewCard;
    exerciseListViewCard.onDeleteListViewCard = onDeleteListViewCard;
  }




  static Superset getDemoSuperset(Function() onDeleteListViewCard,
                                  Function() onDeleteListViewHeader)
  {
    return Superset("Upper Body Bench Superset", [
      Exercise(
        "Dumbbell Bench Press",
        "DBP desc",
        onDeleteListViewCard
      ),
      Exercise(
        "Sitting Overhead Dumbbell Extension",
        "SODE Desc",
        onDeleteListViewCard
      ),
      Exercise(
        "Chest Flies",
        "CF Desc",
        onDeleteListViewCard
      ),
      Exercise(
        "Dumbbell Skull Crushers",
        "DSC Desc",
        onDeleteListViewCard
      ),
    ], onDeleteListViewHeader);
  }
}



class SupersetListViewHeader extends ListViewHeader
{
  SupersetListViewHeader(String title, Key key, bool isDeleteable,
                         Function() onDeleteListViewHeader) :
        super(title, key, isDeleteable, onDeleteListViewHeader);

  SupersetListViewHeader.superset(Superset superset, Key key,
                                  bool isDeleteable,
                                  Function() onDeleteListViewHeader) :
        super(superset.name, key, isDeleteable, onDeleteListViewHeader);

  SupersetListViewHeader.notDeletable(String title, Key key) :
        super.notDeletable(title, key);
}
