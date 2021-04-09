import 'package:Stryde/models/UserExperience.dart';
import 'package:Stryde/models/Workout.dart';
import 'package:Stryde/models/Superset.dart';
import 'package:Stryde/models/Exercise.dart';


class StrydeUserStorage
{
  // All info about the logged in user
  static UserExperience? userExperience;

  // The logged in user's workouts
  static List<Workout>? workouts;

  // The logged in user's supersets
  static List<Superset>? supersets;

  // All exercises the user can add to their workouts & supersets
  static List<Exercise>? allExercises;



  static reset()
  {
    StrydeUserStorage.userExperience = null;
    StrydeUserStorage.workouts = null;
    StrydeUserStorage.supersets = null;
    //StrydeUserStorage.allExercises = null;
  }
}
