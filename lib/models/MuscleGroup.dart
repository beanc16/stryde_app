import 'package:Stryde/models/enums/MuscleGroupEnum.dart';



class MuscleGroup
{
  late final int? id;
  late final MuscleGroupEnum value;

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
