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

  @override
  bool operator ==(Object other)
  =>
      identical(this, other) ||
          other is MuscleGroup &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              value == other.value;

  @override
  int get hashCode
  =>
      id.hashCode ^
      value.hashCode;

}
