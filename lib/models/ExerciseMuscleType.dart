import 'enums/ExerciseMuscleTypeEnum.dart';



class ExerciseMuscleType
{
  int id;
  ExerciseMuscleTypeEnum value;

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
}
