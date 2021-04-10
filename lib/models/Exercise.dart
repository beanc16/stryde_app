import 'package:flutter/cupertino.dart';
import 'package:Stryde/components/listViews/ListViewCard.dart';
import 'package:Stryde/models/ExerciseMuscleType.dart';
import 'package:Stryde/models/MuscleGroup.dart';
import 'package:Stryde/screens/loggedIn/workoutList/EditExerciseInformationScreen.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'ExerciseMovementType.dart';
import 'ExerciseWeightType.dart';
import './enums/ExerciseWeightTypeEnum.dart';
import './enums/ExerciseMuscleTypeEnum.dart';
import './enums/ExerciseMovementTypeEnum.dart';



class Exercise
{
  int? id;
  late final String name;
  late final String? description;
  ExerciseWeightType? exerciseWeightType;
  ExerciseMuscleType? exerciseMuscleType;
  ExerciseMovementType? exerciseMovementType;
  List<MuscleGroup>? muscleGroups;
  late ExerciseListViewCard exerciseListViewCard;

  Exercise(this.name, this.description, 
           Function() onDeleteListViewCard,
           {Function(BuildContext, dynamic)? onTap})
  {
    if (onTap == null)
    {
      onTap = _onTapDefault;
    }

    this.exerciseListViewCard = ExerciseListViewCard(
      this.name,
      this.description,
      UniqueKey(),
      false,
      onDeleteListViewCard,
      onTap: onTap,
    );
  }

  Exercise.notReorderable(this.name, this.description, 
                          {Function(BuildContext, dynamic)? onTap})
  {
    if (onTap == null)
    {
      onTap = _onTapDefault;
    }

    this.exerciseListViewCard = ExerciseListViewCard.notReorderable(
      this.name,
      this.description,
      UniqueKey(),
      false,
      onTap: onTap,
    );
  }

  Exercise.model(this.id, this.name, this.description,
                 String exerciseWeightType, String exerciseMuscleType,
                 String exerciseMovementType,
                 this.muscleGroups, {Function(BuildContext, dynamic)? onTap})
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
      UniqueKey(),
      false,
      onTap: onTap,
    );
  }

  Exercise.duplicate(Exercise exercise,
                     Function(BuildContext, dynamic)? onTap)
  {
    this.id = exercise.id;
    this.name = exercise.name;
    this.description = exercise.description;
    this.exerciseWeightType = exercise.exerciseWeightType;
    this.exerciseMuscleType = exercise.exerciseMuscleType;
    this.exerciseMovementType = exercise.exerciseMovementType;
    this.muscleGroups = exercise.muscleGroups;
    this.exerciseListViewCard = ExerciseListViewCard.notReorderable(
      this.name,
      this.description,
      UniqueKey(),
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

  Exercise duplicate()
  {
    return Exercise.duplicate(this, this.exerciseListViewCard.onTap);
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
  ExerciseListViewCard(String title, String? description, Key key,
                       bool shouldLeftIndent,
                       Function() onDeleteListViewCard,
                       {
                         Function(BuildContext, dynamic)? onTap,
                         Exercise? exercise
                       }) :
        super(title, description, key, shouldLeftIndent,
              onDeleteListViewCard, onTap: onTap, data: exercise);

  ExerciseListViewCard.exercise(Exercise exercise, Key key,
                                bool shouldLeftIndent,
                                Function() onDeleteListViewCard,
                                {
                                  Function(BuildContext, dynamic)? onTap,
                                }) :
        super(exercise.name, exercise.description, key,
              shouldLeftIndent, onDeleteListViewCard, onTap: onTap,
              data: exercise);

  ExerciseListViewCard.notReorderable(String title, String? description,
                                      Key key, bool shouldLeftIndent,
                                      {
                                        Function(BuildContext, dynamic)? onTap,
                                        Exercise? exercise
                                      }) :
        super.notReorderable(title, description, key,
                             shouldLeftIndent, onTap: onTap,
                             data: exercise);



  void indentLeft()
  {
    super.indentLeft();
  }
}
