import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/misc/ListViewCard.dart';



class ExerciseMuscleType
{
  final int id;
  final String name;

  ExerciseMuscleType(this.id, this.name);

  @override
  String toString()
  {
    return 'ExerciseMuscleType{id: $id, name: $name}';
  }
}
