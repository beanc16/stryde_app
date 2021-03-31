import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/misc/ListViewCard.dart';
import 'package:workout_buddy/models/ExerciseMuscleType.dart';
import 'package:workout_buddy/models/MuscleGroup.dart';
import 'ExerciseMovementType.dart';
import 'ExerciseWeightType.dart';



class Exercise
{
  int id;
  final String name;
  final String description;
  ExerciseWeightType exerciseWeightType;
  ExerciseMuscleType exerciseMuscleType;
  ExerciseMovementType exerciseMovementType;
  List<MuscleGroup> muscleGroups;

  ExerciseListViewCard exerciseListViewCard;

  Exercise(this.name, this.description, Function() onDeleteListViewCard)
  {
    this.exerciseListViewCard = ExerciseListViewCard(
      this.name,
      this.description,
      Key("${this.name}"),
      false,
      onDeleteListViewCard
    );
  }

  Exercise.notReorderable(this.name, this.description)
  {
    this.exerciseListViewCard = ExerciseListViewCard.notReorderable(
      this.name,
      this.description,
      Key("${this.name}"),
      false
    );
  }

  Exercise.model(this.id, this.name, this.description,
                 String exerciseWeightType, String exerciseMuscleType,
                 String exerciseMovementType,
                 this.muscleGroups)
  {
    this.exerciseWeightType = ExerciseWeightType(exerciseWeightType);
    this.exerciseMuscleType = ExerciseMuscleType(exerciseMuscleType);
    this.exerciseMovementType = ExerciseMovementType(exerciseMovementType);
  }



  void indentLeft()
  {
    if (exerciseListViewCard != null)
    {
      exerciseListViewCard.indentLeft();
    }
  }

  @override
  String toString()
  {
    return 'Exercise{id: $id, name: $name, description: $description, '
           'exerciseWeightType: $exerciseWeightType, '
           'exerciseMuscleType: $exerciseMuscleType, '
           'exerciseMovementType: $exerciseMovementType, '
           'muscleGroups: $muscleGroups, '
           'exerciseListViewCard: $exerciseListViewCard}';
  }
}



class ExerciseListViewCard extends ListViewCard
{
  ExerciseListViewCard(String title, String description, Key key,
                       bool shouldLeftIndent,
                       Function() onDeleteListViewCard) :
        super(title, description, key, shouldLeftIndent,
              onDeleteListViewCard);

  ExerciseListViewCard.exercise(Exercise exercise, Key key,
                                bool shouldLeftIndent,
                                Function() onDeleteListViewCard) :
        super(exercise.name, exercise.description, key,
              shouldLeftIndent, onDeleteListViewCard);

  ExerciseListViewCard.notReorderable(String title, String description,
                                      Key key, bool shouldLeftIndent) :
        super.notReorderable(title, description, key,
                             shouldLeftIndent);



  void indentLeft()
  {
    super.indentLeft();
  }
}
