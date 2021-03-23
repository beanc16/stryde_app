import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/misc/ListViewCard.dart';



class ExerciseMovementType
{
  final int id;
  final String name;

  ExerciseMovementType(this.id, this.name);

  @override
  String toString()
  {
    return 'ExerciseMovementType{id: $id, name: $name}';
  }
}
