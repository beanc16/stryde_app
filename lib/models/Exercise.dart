import 'dart:core';
import 'package:Stryde/models/ExerciseInformation.dart';
import 'package:Stryde/models/databaseActions/DatabaseActionType.dart';
import 'package:Stryde/models/enums/ExerciseWeightTypeEnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:Stryde/components/listViews/ListViewCard.dart';
import 'package:Stryde/models/ExerciseMuscleType.dart';
import 'package:Stryde/models/MuscleGroup.dart';
import 'package:Stryde/screens/loggedIn/workoutList/EditExerciseInformationScreen.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'ExerciseMovementType.dart';
import 'ExerciseWeightType.dart';
import 'enums/ExerciseMovementTypeEnum.dart';
import 'enums/ExerciseMuscleTypeEnum.dart';



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
  bool? _shouldCreate;

  bool get shouldCreate => _shouldCreate ?? false;

  Exercise(this.name, this.description, 
           Function() onDeleteListViewCard,
           {Function(BuildContext, dynamic)? onTap})
  {
    if (onTap == null)
    {
      onTap = _onTapDefault;
    }

    this.information = [];
    this.muscleGroups = [];

    this.exerciseListViewCard = ExerciseListViewCard(
      this.id!,
      this.name,
      this.description,
      UniqueKey(),
      false,
      onDeleteListViewCard,
      onTap: onTap,
      exerciseWeightType: this.exerciseWeightType,
      exerciseMuscleType: this.exerciseMuscleType,
      exerciseMovementType: this.exerciseMovementType,
      muscleGroups: this.muscleGroups,
      shouldCreate: this.shouldCreate,
      information: this.information,
      exercise: this,
    );
  }

  Exercise.notReorderable(this.name, this.description, 
                          {Function(BuildContext, dynamic)? onTap})
  {
    if (onTap == null)
    {
      onTap = _onTapDefault;
    }

    this.information = [];
    this.muscleGroups = [];

    this.exerciseListViewCard = ExerciseListViewCard.notReorderable(
      this.id!,
      this.name,
      this.description,
      UniqueKey(),
      false,
      onTap: onTap,
      exerciseWeightType: this.exerciseWeightType,
      exerciseMuscleType: this.exerciseMuscleType,
      exerciseMovementType: this.exerciseMovementType,
      muscleGroups: this.muscleGroups,
      shouldCreate: this.shouldCreate,
      information: this.information,
      exercise: this,
    );
  }

  Exercise.model(this.id, this.name, this.description,
                 String exerciseWeightType, String exerciseMuscleType,
                 String exerciseMovementType,
                 this.muscleGroups, {Function(BuildContext, dynamic)? onTap,
                                     bool shouldCreate = false,
                                     List<ExerciseInformation>? information})
  {
    this.exerciseWeightType = ExerciseWeightType(exerciseWeightType);
    this.exerciseMuscleType = ExerciseMuscleType(exerciseMuscleType);
    this.exerciseMovementType = ExerciseMovementType(exerciseMovementType);

    if (onTap == null)
    {
      onTap = _onTapDefault;
    }

    if (information == null)
    {
      this.information = [];
    }
    else
    {
      this.information = information;
    }

    this.exerciseListViewCard = ExerciseListViewCard.notReorderable(
      this.id!,
      this.name,
      this.description,
      UniqueKey(),
      false,
      onTap: onTap,
      exerciseWeightType: this.exerciseWeightType,
      exerciseMuscleType: this.exerciseMuscleType,
      exerciseMovementType: this.exerciseMovementType,
      muscleGroups: this.muscleGroups,
      shouldCreate: this.shouldCreate,
      information: this.information,
      exercise: this,
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
      this.id!,
      this.name,
      this.description,
      UniqueKey(),
      false,
      onTap: onTap,
      exerciseWeightType: exercise.exerciseWeightType,
      exerciseMuscleType: exercise.exerciseMuscleType,
      exerciseMovementType: exercise.exerciseMovementType,
      muscleGroups: exercise.muscleGroups,
      shouldCreate: exercise.shouldCreate,
      information: exercise.information,
      exercise: exercise,
    );
    this.information = exercise.information;
    this._shouldCreate = exercise.shouldCreate;
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

  void addMuscleGroup(String muscleGroupName)
  {
    MuscleGroup mg = MuscleGroup(muscleGroupName);
    this.muscleGroups?.add(mg);
  }

  void addMuscleGroups(List<MuscleGroup>? muscleGroups)
  {
    if (muscleGroups != null && muscleGroups.length > 0)
    {
      this.muscleGroups?.addAll(muscleGroups);
    }
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
    while (index >= this.information.length)
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



  List<dynamic> getUpdatedInformation()
  {
    return this.information.map((ExerciseInformation info) =>
      info.databaseActionType == DatabaseActionType.Update
    ).toList();
  }

  List<Map<String, dynamic>> getAsUpdatedJson(int orderInWorkout)
  {
    // Used to update database
    List<Map<String, dynamic>> output = [];

    if (this.information.length == 0)
    {
      output.add({
        "exerciseId": this.id,
        "orderInWorkout": orderInWorkout,
        //"userExerciseId": null,
      });
    }

    for (int i = 0; i < this.information.length; i++)
    {
      Map<String, dynamic>? curInfo = this.information[i].getAsUpdateJson(orderInWorkout);

      if (curInfo != null)
      {
        if (shouldCreate &&
            (curInfo["shouldCreate"] == null ||
             curInfo["shouldCreate"] == false))
        {
          curInfo["shouldCreate"] = true;
        }

        output.add(curInfo);
      }
    }

    return output;
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

  @override
  bool operator ==(Object other)
  =>
      identical(this, other) ||
          other is Exercise &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              description == other.description &&
              exerciseWeightType == other.exerciseWeightType &&
              exerciseMuscleType == other.exerciseMuscleType &&
              exerciseMovementType == other.exerciseMovementType &&
              muscleGroups == other.muscleGroups &&
              exerciseListViewCard == other.exerciseListViewCard &&
              information == other.information;

  @override
  int get hashCode
  =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      exerciseWeightType.hashCode ^
      exerciseMuscleType.hashCode ^
      exerciseMovementType.hashCode ^
      muscleGroups.hashCode ^
      exerciseListViewCard.hashCode ^
      information.hashCode;

}



class ExerciseListViewCard extends ListViewCard
{
  ExerciseListViewCard(int exerciseId, String title,
                       String? description, Key key,
                       bool shouldLeftIndent,
                       Function() onDeleteListViewCard,
                       {
                         Function(BuildContext, dynamic)? onTap,
                         Exercise? exercise,
                         required ExerciseWeightType? exerciseWeightType,
                         required ExerciseMuscleType? exerciseMuscleType,
                         required ExerciseMovementType? exerciseMovementType,
                         required List<MuscleGroup>? muscleGroups,
                         required bool shouldCreate,
                         required List<ExerciseInformation> information,
                       }) :
        super(exerciseId, title, description, key, shouldLeftIndent,
              onDeleteListViewCard, onTap: onTap, data: exercise,
              exerciseWeightType: exerciseWeightType,
              exerciseMuscleType: exerciseMuscleType,
              exerciseMovementType: exerciseMovementType,
              muscleGroups: muscleGroups,
              shouldCreate: shouldCreate,
              information: information, );

  ExerciseListViewCard.exercise(Exercise exercise, Key key,
                                bool shouldLeftIndent,
                                Function() onDeleteListViewCard,
                                {
                                  Function(BuildContext, dynamic)? onTap,
                                  required ExerciseWeightType? exerciseWeightType,
                                  required ExerciseMuscleType? exerciseMuscleType,
                                  required ExerciseMovementType? exerciseMovementType,
                                  required List<MuscleGroup>? muscleGroups,
                                  required bool shouldCreate,
                                  required List<ExerciseInformation> information,
                                }) :
        super(exercise.id, exercise.name, exercise.description, key,
              shouldLeftIndent, onDeleteListViewCard, onTap: onTap,
              data: exercise,
              exerciseWeightType: exerciseWeightType,
              exerciseMuscleType: exerciseMuscleType,
              exerciseMovementType: exerciseMovementType,
              muscleGroups: muscleGroups,
              shouldCreate: shouldCreate,
              information: information, );

  ExerciseListViewCard.notReorderable(int exerciseId, String title,
                                      String? description,
                                      Key key, bool shouldLeftIndent,
                                      {
                                        Function(BuildContext, dynamic)? onTap,
                                        Exercise? exercise,
                                        required ExerciseWeightType? exerciseWeightType,
                                        required ExerciseMuscleType? exerciseMuscleType,
                                        required ExerciseMovementType? exerciseMovementType,
                                        required List<MuscleGroup>? muscleGroups,
                                        required bool shouldCreate,
                                        required List<ExerciseInformation> information,
                                      }) :
        super.notReorderable(exerciseId, title, description, key,
                             shouldLeftIndent, onTap: onTap,
                             data: exercise,
                             exerciseWeightType: exerciseWeightType,
                             exerciseMuscleType: exerciseMuscleType,
                             exerciseMovementType: exerciseMovementType,
                             muscleGroups: muscleGroups,
                             shouldCreate: shouldCreate,
                             information: information, );



  void indentLeft()
  {
    super.indentLeft();
  }
}
