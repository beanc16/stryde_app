import 'package:workout_buddy/models/enums/MuscleGroupEnum.dart';



class MuscleGroup
{
  int id;
  MuscleGroupEnum value;

  MuscleGroup(String muscleGroup)
  {
    this.value = MuscleGroupEnumHelpers.getFromString(muscleGroup);
    this.id = this.value.getId();
  }

  @override
  String toString()
  {
    return 'MuscleGroup{id: $id, value: ' + value.toStringShort() + '}';
  }
}
