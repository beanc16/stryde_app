import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/misc/ListViewCard.dart';
import 'package:workout_buddy/models/enums/ExerciseMovementTypeEnum.dart';



class ExerciseMovementType
{
  int id;
  ExerciseMovementTypeEnum value;

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
