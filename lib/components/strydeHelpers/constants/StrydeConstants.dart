import 'package:Stryde/models/ExerciseMovementType.dart';
import 'package:Stryde/models/ExerciseMuscleType.dart';
import 'package:Stryde/models/ExerciseWeightType.dart';
import 'package:Stryde/models/MuscleGroup.dart';


class StrydeConstants
{
  static List<MuscleGroup> muscleGroupList = [
    MuscleGroup("Chest"),
    MuscleGroup("Back"),
    MuscleGroup("Biceps"),
    MuscleGroup("Triceps"),
    MuscleGroup("Shoulders"),
    MuscleGroup("Quadriceps"),
    MuscleGroup("Hamstrings"),
    MuscleGroup("Glutes"),
    MuscleGroup("Calves"),
    MuscleGroup("Abs"),
    MuscleGroup("Obliques"),
  ];

  static List<ExerciseWeightType> weightTypeList = [
    ExerciseWeightType("Free Weight"),
    ExerciseWeightType("Body Weight"),
    ExerciseWeightType("Machine"),
  ];

  static List<ExerciseMuscleType> muscleTypeList = [
    ExerciseMuscleType("Compound"),
    ExerciseMuscleType("Isolation"),
  ];

  static List<ExerciseMovementType> movementTypeList = [
    ExerciseMovementType("Horizontal Push"),
    ExerciseMovementType("Horizontal Pull"),
    ExerciseMovementType("Vertical Push"),
    ExerciseMovementType("Vertical Pull"),
    ExerciseMovementType("Quad Dominant"),
    ExerciseMovementType("Hip/Hamstring Dominant"),
    ExerciseMovementType("Elbow Flexion"),
    ExerciseMovementType("Elbow Extension"),
    ExerciseMovementType("Accessory Movements"),
  ];
}
