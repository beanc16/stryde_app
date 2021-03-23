import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/misc/ListViewCard.dart';



class ExerciseWeightType
{
  final int id;
  final String name;

  ExerciseWeightType(this.id, this.name);

  @override
  String toString()
  {
    return 'ExerciseWeightType{id: $id, name: $name}';
  }
}
