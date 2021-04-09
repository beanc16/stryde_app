import 'enums/ExerciseWeightTypeEnum.dart';



class ExerciseWeightType
{
  late final int? id;
  late final ExerciseWeightTypeEnum value;

  ExerciseWeightType(String exerciseWeightType)
  {
    this.value = ExerciseWeightTypeEnumHelpers.getFromString(exerciseWeightType);
    this.id = this.value.getId();
  }

  @override
  String toString()
  {
    return 'ExerciseWeightType{id: $id, value: ' + value.toStringShort() + '}';
  }
}
