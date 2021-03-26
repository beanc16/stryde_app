import 'package:workout_buddy/models/UserExperience.dart';
import 'package:workout_buddy/models/Workout.dart';
import 'package:workout_buddy/models/Superset.dart';


class StrydeUserStorage
{
  // All info about the logged in user
  static UserExperience userExperience = null;

  // The logged in user's workouts
  static List<Workout> workouts = null;

  // The logged in user's supersets
  static List<Superset> supersets = null;



  static reset()
  {
    StrydeUserStorage.userExperience = null;
    StrydeUserStorage.workouts = null;
    StrydeUserStorage.supersets = null;
  }
}
