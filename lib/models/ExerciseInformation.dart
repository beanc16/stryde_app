import 'databaseActions/DatabaseAction.dart';
import 'databaseActions/DatabaseActionType.dart';


class ExerciseInformation
{
  int userExerciseId;
  String? description;
  int? sets;
  int? reps;
  int? weight;
  String? duration;
  String? distance;
  String? resistance;
  //late DatabaseAction databaseAction;
  late DatabaseActionType databaseActionType;

  ExerciseInformation({
    this.userExerciseId = -1,
    this.description,
    this.sets,
    this.reps,
    this.weight,
    this.duration,
    this.distance,
    this.resistance,
    DatabaseActionType? databaseActionType,
    bool shouldCreate = false,
  })
  {
    this.databaseActionType = databaseActionType ?? DatabaseActionType.None;

    if (shouldCreate)
    {
      this.databaseActionType = DatabaseActionType.Insert;
    }
    /*
    this.databaseAction = DatabaseAction(
      oldInfo: this.duplicate(),
      actionType: databaseAction ?? DatabaseActionType.None,
    );
    */
  }

  ExerciseInformation.copy(ExerciseInformation info) :
    this(
      userExerciseId: info.userExerciseId,
      description: info.description,
      sets: info.sets,
      reps: info.reps,
      weight: info.weight,
      duration: info.duration,
      distance: info.distance,
      resistance: info.resistance,
      shouldCreate: (info.databaseActionType == DatabaseActionType.Insert) ? true : false
    );



  ExerciseInformation duplicate({
    int? userExerciseId,
    String? description,
    int? sets,
    int? reps,
    int? weight,
    String? duration,
    String? resistance,
    bool? shouldCreate
  })
  {
    return ExerciseInformation(
      userExerciseId: userExerciseId ?? this.userExerciseId,
      description: description ?? this.description,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      duration: duration ?? this.duration,
      resistance: resistance ?? this.resistance,
      shouldCreate: shouldCreate ??
                    (this.databaseActionType == DatabaseActionType.Insert) ? true : false
    );
  }



  void update({
    int? userExerciseId,
    String? description,
    int? sets,
    int? reps,
    int? weight,
    String? duration,
    String? resistance,
    bool shouldCreate = false
  })
  {
    bool wasChanged = false;

    if (userExerciseId != null)
    {
      this.userExerciseId = userExerciseId;
      wasChanged = true;
    }

    if (description != null)
    {
      this.description = description;
      wasChanged = true;
    }

    if (sets != null)
    {
      this.sets = sets;
      wasChanged = true;
    }

    if (reps != null)
    {
      this.reps = reps;
      wasChanged = true;
    }

    if (weight != null)
    {
      this.weight = weight;
      wasChanged = true;
    }

    if (duration != null)
    {
      this.duration = duration;
      wasChanged = true;
    }

    if (resistance != null)
    {
      this.resistance = resistance;
      wasChanged = true;
    }

    if (wasChanged)
    {
      this.databaseActionType = DatabaseActionType.Update;
      /*
      this.databaseAction.update(
        newInfo: this,
      );
      */
    }

    if (shouldCreate)
    {
      this.databaseActionType = DatabaseActionType.Insert;
    }
  }

  Map<String, dynamic>? getAsUpdateJson(int orderInWorkout)
  {
    // This information hasn't been changed
    //if (!this.databaseAction.hasChanged)
    if (this.databaseActionType == DatabaseActionType.None)
    {
      return null;
    }

    // Used to update info in database
    Map<String, dynamic> output = {
      "userExerciseId": this.userExerciseId,
      "orderInWorkout": orderInWorkout,
    };

    // Add each value only if it's not null
    if (this.description != null)
    {
      output["ueiDescription"] = this.description;
    }
    if (this.sets != null)
    {
      output["ueiSets"] = this.sets;
    }
    if (this.reps != null)
    {
      output["ueiReps"] = this.reps;
    }
    if (this.weight != null)
    {
      output["ueiWeight"] = this.weight;
    }
    if (this.duration != null)
    {
      output["ueiDuration"] = this.duration;
    }
    if (this.resistance != null)
    {
      output["ueiResistance"] = this.resistance;
    }


    if (this.databaseActionType == DatabaseActionType.Delete)
    {
      output.addAll({
        "shouldDelete": true,
        "shouldCreate": false,
      });
    }
    else if (this.databaseActionType == DatabaseActionType.Insert)
    {
      output.addAll({
        "shouldCreate": true,
        "shouldDelete": false,
      });
    }
    else if (this.databaseActionType == DatabaseActionType.Update &&
             this.databaseActionType == DatabaseActionType.None)
    {
      output.addAll({
        "shouldCreate": false,
        "shouldDelete": false,
      });
    }

    return output;
  }


  @override
  String toString()
  {
    return 'ExerciseInformation{'
              'userExerciseId: $userExerciseId, '
              'description: $description, sets: $sets, reps: $reps, '
              'weight: $weight, duration: $duration, '
              'distance: $distance, resistance: $resistance}';
  }

  @override
  bool operator ==(Object other)
  =>
      identical(this, other) ||
          other is ExerciseInformation &&
              runtimeType == other.runtimeType &&
              userExerciseId == other.userExerciseId &&
              description == other.description &&
              sets == other.sets &&
              reps == other.reps &&
              weight == other.weight &&
              duration == other.duration &&
              distance == other.distance &&
              resistance == other.resistance;

  @override
  int get hashCode
  =>
      userExerciseId.hashCode ^
      description.hashCode ^
      sets.hashCode ^
      reps.hashCode ^
      weight.hashCode ^
      duration.hashCode ^
      distance.hashCode ^
      resistance.hashCode;

}