import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/listViews/ListViewCard.dart';
import 'package:workout_buddy/models/ExerciseMuscleType.dart';
import 'package:workout_buddy/models/MuscleGroup.dart';
import 'package:workout_buddy/screens/loggedIn/workoutList/EditExerciseInformationScreen.dart';
import 'package:workout_buddy/utilities/NavigateTo.dart';
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

  Exercise(this.name, this.description, 
           Function() onDeleteListViewCard,
           {Function(BuildContext, dynamic) onTap})
  {
    if (onTap == null)
    {
      onTap = _onTapDefault;
    }

    this.exerciseListViewCard = ExerciseListViewCard(
      this.name,
      this.description,
      Key("${this.name}"),
      false,
      onDeleteListViewCard,
      onTap: onTap,
    );
  }

  Exercise.notReorderable(this.name, this.description, 
                          {Function(BuildContext, dynamic) onTap})
  {
    if (onTap == null)
    {
      onTap = _onTapDefault;
    }

    this.exerciseListViewCard = ExerciseListViewCard.notReorderable(
      this.name,
      this.description,
      Key("${this.name}"),
      false,
      onTap: onTap,
    );
  }

  Exercise.model(this.id, this.name, this.description,
                 String exerciseWeightType, String exerciseMuscleType,
                 String exerciseMovementType,
                 this.muscleGroups, {Function(BuildContext, dynamic) onTap})
  {
    this.exerciseWeightType = ExerciseWeightType(exerciseWeightType);
    this.exerciseMuscleType = ExerciseMuscleType(exerciseMuscleType);
    this.exerciseMovementType = ExerciseMovementType(exerciseMovementType);

    if (onTap == null)
    {
      onTap = _onTapDefault;
    }

    this.exerciseListViewCard = ExerciseListViewCard.notReorderable(
      this.name,
      this.description,
      Key("${this.name}"),
      false,
      onTap: onTap,
    );
  }

  void _onTapDefault(BuildContext context, dynamic data)
  {
    NavigateTo.screen(
      context,
      () => EditExerciseInformationScreen(this),
    );
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
                       Function() onDeleteListViewCard,
                       {
                         Function(BuildContext, dynamic) onTap,
                         Exercise exercise
                       }) :
        super(title, description, key, shouldLeftIndent,
              onDeleteListViewCard, onTap: onTap, data: exercise);

  ExerciseListViewCard.exercise(Exercise exercise, Key key,
                                bool shouldLeftIndent,
                                Function() onDeleteListViewCard,
                                {
                                  Function(BuildContext, dynamic) onTap,
                                }) :
        super(exercise.name, exercise.description, key,
              shouldLeftIndent, onDeleteListViewCard, onTap: onTap,
              data: exercise);

  ExerciseListViewCard.notReorderable(String title, String description,
                                      Key key, bool shouldLeftIndent,
                                      {
                                        Function(BuildContext, dynamic) onTap,
                                        Exercise exercise
                                      }) :
        super.notReorderable(title, description, key,
                             shouldLeftIndent, onTap: onTap,
                             data: exercise);



  void indentLeft()
  {
    super.indentLeft();
  }
}
