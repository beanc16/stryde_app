import 'enums/ExerciseMuscleTypeEnum.dart';



class ExerciseMuscleType
{
  late final int? id;
  late final ExerciseMuscleTypeEnum value;

  ExerciseMuscleType(String exerciseMuscleType)
  {
    this.value = ExerciseMuscleTypeEnumHelpers.getFromString(exerciseMuscleType);
    this.id = this.value.getId();
  }

  @override
  String toString()
  {
    return 'ExerciseMuscleType{id: $id, value: ' + value.toStringShort() + '}';
  }

  @override
  bool operator ==(Object other)
  =>
      identical(this, other) ||
          other is ExerciseMuscleType &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              value == other.value;

  @override
  int get hashCode
  =>
      id.hashCode ^
      value.hashCode;

}
