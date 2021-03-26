import 'package:workout_buddy/models/ExerciseMovementType.dart';
import 'package:workout_buddy/models/ExerciseMuscleType.dart';
import 'package:workout_buddy/models/ExerciseWeightType.dart';
import 'package:workout_buddy/models/MuscleGroup.dart';


class StrydeConstants
{
  static List<MuscleGroup> muscleGroupList = [
    MuscleGroup(1, "Chest"),
    MuscleGroup(2, "Back"),
    MuscleGroup(7, "Biceps"),
    MuscleGroup(8, "Triceps"),
    MuscleGroup(6, "Shoulders"),
    MuscleGroup(3, "Quadriceps"),
    MuscleGroup(4, "Hamstrings"),
    MuscleGroup(5, "Glutes"),
    MuscleGroup(12, "Calves"),
    MuscleGroup(10, "Abs"),
    MuscleGroup(11, "Obliques"),
  ];

  static List<ExerciseWeightType> weightTypeList = [
    ExerciseWeightType(1, "Free Weight"),
    ExerciseWeightType(2, "Body Weight"),
    ExerciseWeightType(3, "Machine"),
  ];

  static List<ExerciseMuscleType> muscleTypeList = [
    ExerciseMuscleType(1, "Compound"),
    ExerciseMuscleType(2, "Isolation"),
  ];

  static List<ExerciseMovementType> movementTypeList = [
    ExerciseMovementType(1, "Horizontal Push"),
    ExerciseMovementType(2, "Horizontal Pull"),
    ExerciseMovementType(3, "Vertical Push"),
    ExerciseMovementType(4, "Vertical Pull"),
    ExerciseMovementType(5, "Quad Dominant"),
    ExerciseMovementType(6, "Hip/Hamstring Dominant"),
    ExerciseMovementType(7, "Elbow Flexion"),
    ExerciseMovementType(8, "Elbow Extension"),
    ExerciseMovementType(9, "Accessory Movements"),
  ];
}
