import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/misc/ListViewCard.dart';



class MuscleGroup
{
  final int id;
  final String name;

  MuscleGroup(this.id, this.name);

  @override
  String toString()
  {
    return 'MuscleGroup{id: $id, name: $name}';
  }
}
