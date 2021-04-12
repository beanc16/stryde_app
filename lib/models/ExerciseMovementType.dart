import 'package:Stryde/models/enums/ExerciseMovementTypeEnum.dart';



class ExerciseMovementType
{
  late final int? id;
  late final ExerciseMovementTypeEnum value;

  ExerciseMovementType(String exerciseMovementType)
  {
    this.value = ExerciseMovementTypeEnumHelpers.getFromString(exerciseMovementType);
    this.id = this.value.getId();
  }

  @override
  String toString()
  {
    return 'ExerciseMovementType{id: $id, value: ' + value.toStringShort() + '}';
  }

  @override
  bool operator ==(Object other)
  =>
      identical(this, other) ||
          other is ExerciseMovementType &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              value == other.value;

  @override
  int get hashCode
  =>
      id.hashCode ^
      value.hashCode;

}
