import 'package:Stryde/models/Exercise.dart';
import 'package:Stryde/models/Superset.dart';
import 'package:Stryde/models/Workout.dart';

class NonEmptyWorkoutMap
{
  //late Map<int, Map<String, Map<int, dynamic>>> map;
  late Map<int, Workout> exercisesAndSupersetsInWorkouts;
  late Map<int, Superset> exercisesInSupersets;

  NonEmptyWorkoutMap()
  {
    exercisesAndSupersetsInWorkouts = {
      /*
      workoutId: Workout(),
      */
    };
    exercisesInSupersets = {
      /*
      orderInSuperset: Superset(),
      */
    };
  }

  void addNewExerciseInWorkout(Exercise newExercise, int orderInWorkout,
                               Workout workout)
  {
    tryAddWorkout(workout);

    if (exercisesAndSupersetsInWorkouts[workout.workoutId] != null)
    {
      exercisesAndSupersetsInWorkouts[workout.workoutId]
        ?.insertExerciseOrSuperset(
        newExercise, orderInWorkout - 1
      );
    }
  }

  void addNewSupersetInWorkout(Superset newSuperset, int orderInWorkout,
                               Workout workout)
  {
    tryAddWorkout(workout);

    if (exercisesAndSupersetsInWorkouts[workout.workoutId] != null)
    {
      exercisesAndSupersetsInWorkouts[workout.workoutId]
          ?.insertExerciseOrSuperset(newSuperset, orderInWorkout - 1);
    }
  }

  void addNewExerciseInSuperset(Exercise newExercise, int orderInSuperset,
                                Superset superset)
  {
    if (exercisesInSupersets[orderInSuperset] == null)
    {
      exercisesInSupersets[orderInSuperset] = superset;
    }

    if (exercisesInSupersets[orderInSuperset] != null)
    {
      exercisesInSupersets[orderInSuperset]?.insertExercise(
        newExercise, orderInSuperset - 1
      );
    }
  }

  void tryAddWorkout(Workout workout)
  {
    // Add the workout if it's not in the map
    if (!workoutIsInMap(workout))
    {
      exercisesAndSupersetsInWorkouts[workout.workoutId] = workout;
    }
  }



  List<Workout> toList()
  {
    exercisesAndSupersetsInWorkouts.forEach((int workoutId, Workout workout)
    {
      for (int i = 0; i < workout.exercisesAndSupersets.length; i++)
      {
        Object exerciseOrSuperset = workout.exercisesAndSupersets[i];

        // Replace each superset's empty list of exercises with the
        // full list of exercises
        if (exerciseOrSuperset is Superset)
        {
          int orderInSuperset = i + 1;
          Superset? superset = exercisesInSupersets[orderInSuperset];

          if (superset != null)
          {
            exerciseOrSuperset.exercises = superset.exercises;
          }
        }
      }
    });

    return exercisesAndSupersetsInWorkouts.values.toList();
  }

  bool workoutIsInMap(Workout workout)
  {
    int workoutId = workout.workoutId;
    return (exercisesAndSupersetsInWorkouts[workoutId] != null);
  }

  @override
  String toString()
  {
    String str = "exercisesAndSupersetsInWorkouts: {\n";

    exercisesAndSupersetsInWorkouts.forEach((int workoutId, Workout workout)
    {
      str += "\tworkoutId ($workoutId): $workout,\n";
    });
    str += "},\n" + "exercisesInSupersets: {\n";

    exercisesInSupersets.forEach((int orderInSuperset, Superset superset)
    {
      str += "\torderInSuperset ($orderInSuperset): $superset,\n";
    });
    str += "}";

    return str;
  }
}