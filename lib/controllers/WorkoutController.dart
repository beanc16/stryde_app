import 'dart:collection';

import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:Stryde/controllers/NonEmptyWorkoutMap.dart';
import 'package:Stryde/models/Exercise.dart';
import 'package:Stryde/models/MuscleGroup.dart';
import 'package:Stryde/models/Workout.dart';
import 'package:Stryde/models/Superset.dart';
import 'package:Stryde/utilities/HttpQueryHelper.dart';


class WorkoutController
{
  static void setAll({
    required Function(List<Workout>) onQuerySuccess,
    required Function(dynamic) onQueryFailureCallback,
  })
  {
    // Get all workouts created by the current user
    String? userId = StrydeUserStorage.userExperience?.id.toString();
    HttpQueryHelper.get("/user/workouts/" + (userId ?? ""),
      onSuccess: (response) => _onGetWorkoutsSuccess(response["_results"],
                                                     onQuerySuccess),
      onFailure: (response) => onQueryFailureCallback(response),
    );
  }

  static void _onGetWorkoutsSuccess(Map<String, dynamic> workoutsJson,
                                    Function(List<Workout>) onSuccessCallback)
  {
    print("workoutsJson:\n" + workoutsJson.toString());

    // Convert workouts to model
    List<Workout> workouts = _convertWorkoutResults(
      workoutsJson["nonEmptyWorkoutResults"]["_results"],
      workoutsJson["emptyWorkoutResults"]["_results"]
    );

    // Set workouts to semi-permanent local storage
    StrydeUserStorage.workouts = workouts;

    onSuccessCallback(workouts);
  }

  static List<Workout> _convertWorkoutResults(List<dynamic> nonEmptyWorkouts,
                                       List<dynamic> emptyWorkouts)
  {
    List<Workout> allWorkouts = _convertNonEmptyWorkouts(nonEmptyWorkouts);
    return _convertEmptyWorkouts(emptyWorkouts, allWorkouts);
  }

  static List<Workout> _convertNonEmptyWorkouts(List<dynamic> nonEmptyWorkouts)
  {
    print("nonEmptyWorkouts: " + nonEmptyWorkouts.toString());

    // Helper variables
    NonEmptyWorkoutMap map = NonEmptyWorkoutMap();
    Workout? curWorkout;
    Workout? newWorkout;
    Superset? curSuperset;
    Superset? newSuperset;
    Exercise? curExercise;
    Exercise? newExercise;

    for (int i = 0; i < nonEmptyWorkouts.length; i++)
    {
      /*
        TODO: Test this with the following versions:
              (success) exerciseInWorkout
              - supersetInWorkout
              - exerciseInSuperset && supersetInWorkout
              - exerciseInWorkout && supersetInWorkout
              - exerciseInWorkout && exerciseInSuperset && supersetInWorkout
       */
      dynamic curInfo = nonEmptyWorkouts[i];

      // The current info is about an exercise in a workout
      if (curInfo["workoutId"] != null &&
          curInfo["exerciseId"] != null)
      {
        newWorkout = wcHelpers.tryCreateNewWorkout(curInfo, curWorkout);
        newExercise = wcHelpers.tryCreateNewExercise(curInfo, curExercise);
        newExercise = wcHelpers.tryUpdateExerciseInfo(curInfo, newExercise,
                                                      curExercise);

        if (curWorkout == null && newWorkout != null)
        {
          curWorkout = newWorkout.duplicate();
        }
        if (curExercise == null && newExercise != null)
        {
          curExercise = newExercise.duplicate();
        }

        if (newExercise != null &&
            curWorkout != null && newWorkout != null &&
            newExercise != curExercise)
        {
          map.addNewExerciseInWorkout(newExercise,
                                      curInfo["orderInWorkout"],
                                      curWorkout);
          curWorkout = newWorkout.duplicate();
          curExercise = newExercise.duplicate();
        }
      }

      // The current info is about a superset in a workout
      else if (curInfo["workoutId"] != null &&
               curInfo["supersetId"] != null)
      {
        // TODO: Update MySQL & test this version of the code
        newWorkout = wcHelpers.tryCreateNewWorkout(curInfo, curWorkout);
        newSuperset = wcHelpers.tryCreateNewSuperset(curInfo, curSuperset);

        if (curWorkout == null && newWorkout != null)
        {
          curWorkout = newWorkout.duplicate();
        }
        if (curSuperset == null && newSuperset != null)
        {
          curSuperset = newSuperset.duplicate();
        }

        if (newSuperset != null &&
            curWorkout != null && newWorkout != null &&
            newSuperset != curSuperset)
        {
          map.addNewSupersetInWorkout(newSuperset,
                                      curInfo["orderInWorkout"],
                                      curWorkout);
          curWorkout = newWorkout.duplicate();
          curSuperset = newSuperset.duplicate();
        }
      }

      // The current info is about an exercise in a superset
      else if (curInfo["exerciseId"] != null &&
               curInfo["supersetId"] != null)
      {
        // TODO: Update MySQL & test this version of the code
        newSuperset = wcHelpers.tryCreateNewSuperset(curInfo, curSuperset);
        newExercise = wcHelpers.tryCreateNewExercise(curInfo, curExercise);
        newExercise = wcHelpers.tryUpdateExerciseInfo(curInfo, newExercise,
                                                      curExercise);

        if (curSuperset == null && newSuperset != null)
        {
          curSuperset = newSuperset.duplicate();
        }
        if (curExercise == null && newExercise != null)
        {
          curExercise = newExercise.duplicate();
        }

        if (newExercise != null &&
            curSuperset != null && /*newSuperset != null &&*/
            newExercise != curExercise)
        {
          map.addNewExerciseInSuperset(newExercise,
                                       curInfo["orderInSuperset"],
                                       curSuperset);
          curSuperset = newSuperset?.duplicate();
          curExercise = newExercise.duplicate();
        }
      }
    }

    if (curWorkout != null)
    {
      if (curSuperset != null)
      {
        curWorkout.addExerciseOrSuperset(curSuperset);
      }

      map.tryAddWorkout(curWorkout);
    }

    return map.toList();
  }

  static List<Workout> _convertEmptyWorkouts(List<dynamic> emptyWorkouts,
                                             List<Workout> curWorkouts)
  {
    for (int i = 0; i < emptyWorkouts.length; i++)
    {
      Map<String, dynamic> workout = emptyWorkouts[i];

      curWorkouts.add(Workout(
        workout["name"], [], description: workout["description"],
        userId: workout["userId"], workoutId: workout["workoutId"],
      ));
    }

    return curWorkouts;
  }
}





// Helpers to keep the main controller class cleaner
extension wcHelpers on WorkoutController
{
  static Workout? tryCreateNewWorkout(dynamic curInfo,
                                      Workout? curWorkout)
  {
    if (curWorkout == null ||
        curWorkout.workoutId != curInfo["workoutId"])
    {
      curWorkout = wcHelpers.getNewWorkout(curInfo);
    }

    return curWorkout;
  }

  static Workout getNewWorkout(dynamic curInfo)
  {
    return Workout(
      curInfo["workoutName"], [],
      workoutId: curInfo["workoutId"],
      userId: curInfo["userId"],
      description: curInfo["workoutDescription"] ?? "",
    );
  }


  static Exercise? tryCreateNewExercise(dynamic curInfo,
                                        Exercise? curExercise)
  {
    Exercise? newExercise;

    if (curExercise == null ||
        curExercise.id != curInfo["exerciseId"])
    {
      // Create exercise w/ exercise information
      newExercise = wcHelpers.getNewExercise(curInfo);
    }

    return newExercise;
  }

  static Exercise getNewExercise(dynamic curInfo)
  {
    Exercise exercise = Exercise.model(
      curInfo["exerciseId"], curInfo["exerciseName"],
      curInfo["exerciseDescription"] ?? "",
      curInfo["exerciseWeightTypeName"],
      curInfo["exerciseMuscleTypeName"],
      curInfo["exerciseMovementTypeName"],
      [],
    );

    exercise.updateInformation(
      0, userExerciseId: curInfo["userExerciseId"],
      description: curInfo["ueiDescription"],
      sets: curInfo["ueiSets"],
      reps: curInfo["ueiReps"],
      weight: curInfo["ueiWeight"],
      duration: curInfo["ueiDuration"],
      resistance: curInfo["ueiResistance"],
    );

    return exercise;
  }


  static Exercise? tryUpdateExerciseInfo(dynamic curInfo,
                                         Exercise? newExercise,
                                         Exercise? curExercise)
  {
    Exercise? outputExercise;

    if (newExercise != null &&
        newExercise.id == curInfo["exerciseId"])
    {
      // Update existing exercise's information
      outputExercise = wcHelpers.updateExerciseInfo(curInfo,
                                                    newExercise);
    }

    if (curInfo["mgName"] != null)
    {
      // Other muscle groups already exist, ignore newExercise
      if (outputExercise == null && curExercise != null)
      {
        curExercise.addMuscleGroup(curInfo["mgName"]);
        return null;
      }

      // First muscle group needs added, return output for newExercise
      else if (outputExercise == null && newExercise != null)
      {
        outputExercise = newExercise.duplicate();
      }

      // Add MuscleGroup to exercise
      outputExercise?.addMuscleGroup(curInfo["mgName"]);
    }

    return outputExercise;
  }

  static Exercise updateExerciseInfo(dynamic curInfo,
                                     Exercise exercise)
  {
    Exercise? newExercise = Exercise.duplicate(
      exercise, exercise.exerciseListViewCard.onTap,
    );

    newExercise.updateInformation(
      0, userExerciseId: curInfo["userExerciseId"],
      description: curInfo["ueiDescription"],
      sets: curInfo["ueiSets"],
      reps: curInfo["ueiReps"],
      weight: curInfo["ueiWeight"],
      duration: curInfo["ueiDuration"],
      resistance: curInfo["ueiResistance"],
    );

    return newExercise;
  }


  static Superset? tryCreateNewSuperset(dynamic curInfo,
    Superset? curSuperset)
  {
    Superset? newSuperset;

    if (curSuperset == null ||
        curSuperset.id != curInfo["supersetId"])
    {
      // Create exercise w/ exercise information
      newSuperset = wcHelpers.getNewSuperset(curInfo);
    }

    return newSuperset;
  }

  static Superset getNewSuperset(dynamic curInfo)
  {
    return Superset.model(
      id: curInfo["supersetId"],
      name: curInfo["supersetName"],
    );
  }
}
