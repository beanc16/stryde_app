import 'package:Stryde/models/ExerciseInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:Stryde/components/listViews/ListViewCard.dart';
import 'package:Stryde/models/ExerciseMuscleType.dart';
import 'package:Stryde/models/MuscleGroup.dart';
import 'package:Stryde/screens/loggedIn/workoutList/EditExerciseInformationScreen.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'ExerciseMovementType.dart';
import 'ExerciseWeightType.dart';



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
  late List<ExerciseInformation> information;

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

    this.information = [];
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

    this.information = [];
  }

  Exercise.model(this.id, this.name, this.description,
                 String exerciseWeightType, String exerciseMuscleType,
                 String exerciseMovementType,
                 this.muscleGroups, {Function(BuildContext, dynamic)? onTap,
                   /*
                   int? userExerciseId, String? ueiDescription,
                   int? sets, int? reps, int? weight, String? duration,
                   String? distance, String? resistance,
                   */
                 })
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

    this.information = [];
    /*
    this.information = ExerciseInformation(
      userExerciseId: (userExerciseId)!,
      description: ueiDescription,
      sets: sets,
      reps: reps,
      weight: weight,
      duration: duration,
      distance: distance,
      resistance: resistance,
    );
    */
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
    this.information = exercise.information;
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

  void updateInformation(int index, {
    int? userExerciseId,
    String? description,
    int? sets,
    int? reps,
    int? weight,
    String? duration,
    String? resistance,
  })
  {
    while(index >= this.information.length)
    {
      this.information.add(ExerciseInformation());
    }

    this.information[index].update(
      userExerciseId: userExerciseId,
      description: description,
      sets: sets,
      reps: reps,
      weight: weight,
      duration: duration,
      resistance: resistance,
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
           'exerciseListViewCard: $exerciseListViewCard '
           'information: $information}';
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
