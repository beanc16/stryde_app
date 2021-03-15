import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/misc/ListViewCard.dart';



class Exercise
{
  final String name;
  final String description;
  ExerciseListViewCard exerciseListViewCard;

  Exercise(this.name, this.description, Function() onDeleteListViewCard)
  {
    this.exerciseListViewCard = ExerciseListViewCard(
      this.name,
      this.description,
      Key("${this.name}"),
      false,
      onDeleteListViewCard
    );
  }

  Exercise.notReorderable(this.name, this.description)
  {
    this.exerciseListViewCard = ExerciseListViewCard.notReorderable(
      this.name,
      this.description,
      Key("${this.name}"),
      false
    );
  }

  void indentLeft()
  {
    exerciseListViewCard.indentLeft();
  }

  @override
  String toString()
  {
    //return 'Exercise{name: $name, description: $description}';
    return 'Exercise{name: $name}';
  }
}



class ExerciseListViewCard extends ListViewCard
{
  ExerciseListViewCard(String title, String description, Key key,
                       bool shouldLeftIndent,
                       Function() onDeleteListViewCard) :
        super(title, description, key, shouldLeftIndent,
              onDeleteListViewCard);

  ExerciseListViewCard.exercise(Exercise exercise, Key key,
                                bool shouldLeftIndent,
                                Function() onDeleteListViewCard) :
        super(exercise.name, exercise.description, key,
              shouldLeftIndent, onDeleteListViewCard);

  ExerciseListViewCard.notReorderable(String title, String description,
                                      Key key, bool shouldLeftIndent) :
        super.notReorderable(title, description, key,
                             shouldLeftIndent);



  void indentLeft()
  {
    super.indentLeft();
  }
}
