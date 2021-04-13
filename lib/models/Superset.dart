import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/listViews/ListViewHeader.dart';
import 'package:Stryde/models/Exercise.dart';



class Superset
{
  late int id;
  late String name;
  late List<Exercise> exercises;
  late SupersetListViewHeader listViewHeader;
  late bool isReorderable = true;

  Superset(this.name, this.exercises,
           Function() onDeleteListViewHeader)
  {
    this.listViewHeader = SupersetListViewHeader(
      this.name,
      UniqueKey(),
      true,
      onDeleteListViewHeader
    );
  }

  Superset.notDeletable(this.name, this.exercises)
  {
    this.listViewHeader = SupersetListViewHeader.notDeletable(
      this.name,
      UniqueKey(),
    );

    this.isReorderable = false;
  }

  Superset.model({
    required this.id,
    required this.name,
    List<Exercise>? exercises,
    SupersetListViewHeader? listViewHeader,
  })
  {
    this.isReorderable = false;

    if (exercises != null)
    {
      this.exercises = exercises;
    }
    else
    {
      this.exercises = [];
    }

    if (listViewHeader != null)
    {
      this.listViewHeader = listViewHeader;
    }
    else
    {
      this.listViewHeader = SupersetListViewHeader.notDeletable(
        this.name,
        UniqueKey(),
      );
    }
  }

  Superset duplicate()
  {
    return Superset.model(
      id: this.id,
      name: this.name,
      exercises: this.exercises,
      listViewHeader: this.listViewHeader,
    );
  }



  void addExercise(Exercise exercise)
  {
    this.exercises.add(exercise);
  }

  void insertExercise(Exercise exercise, int index)
  {
    this.exercises.insert(index, exercise);
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

  @override
  bool operator ==(Object other)
  =>
      identical(this, other) ||
          other is Superset &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              exercises == other.exercises &&
              isReorderable == other.isReorderable;

  @override
  int get hashCode
  =>
      id.hashCode ^
      name.hashCode ^
      exercises.hashCode ^
      isReorderable.hashCode;

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
