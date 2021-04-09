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
}
