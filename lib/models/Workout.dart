import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:workout_buddy/components/misc/ListViewCard.dart';
import 'package:workout_buddy/components/misc/ListViewHeader.dart';
import 'package:workout_buddy/models/Exercise.dart';

import 'Superset.dart';



class Workout
{
  final String name;
  final List<Object> exercisesAndSupersets;
  bool isReorderable = true;

  Workout(this.name, this.exercisesAndSupersets);

  Workout.notReorderable(this.name, this.exercisesAndSupersets)
  {
    this.isReorderable = false;
  }



  List<Widget> getAsWidgets()
  {
    List<Widget> children = [];
    int numOfDividers = 0;
    bool inSuperset = false;

    for (int i = 0; i < exercisesAndSupersets.length; i++)
    {
      Object exerciseOrSuperset = exercisesAndSupersets[i];

      if (exerciseOrSuperset is Exercise)
      {
        if (inSuperset)
        {
          inSuperset = false;
          children.add(Divider(
            key: Key("Divider ${numOfDividers++}"),
            thickness: 3,
            color: Colors.black38
          ));
        }

        ExerciseListViewCard elvc = exerciseOrSuperset.exerciseListViewCard;
        elvc.setIsReorderable(this.isReorderable);
        children.add(elvc);
      }

      else if (exerciseOrSuperset is Superset)
      {
        inSuperset = true;

        if (i != 0)
        {
          children.add(Divider(
            key: Key("Divider ${numOfDividers++}"),
            thickness: 3,
            color: Colors.black38
          ));
        }

        SupersetListViewHeader slvh = exerciseOrSuperset.listViewHeader;
        slvh.setIsDeleteable(this.isReorderable);
        children.add(slvh);

        for (Exercise exercise in exerciseOrSuperset.exercises)
        {
          exercise.indentLeft();
          ExerciseListViewCard elvc = exercise.exerciseListViewCard;
          elvc.setIsReorderable(this.isReorderable);
          children.add(elvc);
        }

        // Enable this to get room for exercises between supersets
        /*
        children.add(Divider(
          key: Key("Divider ${numOfDividers++}"),
          thickness: 3,
          color: Colors.black38
        ));
         */
      }
    }

    if (children.length <= 0)
    {
      children.add(
        Text(
          "No Exercises",
          key: Key("No Exercises"),
        )
      );
    }

    return children;
  }

  ListView getAsListView()
  {
    List<Widget> exercisesAndSupersetsListViewCardsAndHeaders = this.getAsWidgets();

    if (exercisesAndSupersetsListViewCardsAndHeaders.length <= 0)
    {
      List<Widget> emptyWorkoutList = [
        Text("No Exercises."),
      ];

      return ListView(
        key: Key(this.name),
        children: emptyWorkoutList,
        shrinkWrap: true,
      );
    }

    return ListView(
      key: Key(this.name),
      children: exercisesAndSupersetsListViewCardsAndHeaders,
      shrinkWrap: true,
    );
  }



  void updateDeleteListViewCardFunc(Function() onDeleteListViewCard,
                                    int index,
                                    List<Widget> listViewCards)
  {
    int iterations = 0;
    for (Object exerciseOrSuperset in exercisesAndSupersets)
    {
      if (exerciseOrSuperset is Superset)
      {
        bool shouldEnd = false;

        if (iterations == index)
        {
          _updateDeleteFunc(exerciseOrSuperset, onDeleteListViewCard);
          shouldEnd = true;
        }

        for (Exercise exercise in exerciseOrSuperset.exercises)
        {
          iterations++;

          if (iterations == index)
          {
            _updateDeleteFunc(exercise, onDeleteListViewCard);
            return;
          }
        }

        if (shouldEnd)
        {
          return;
        }

        iterations++;
      }

      else if (exerciseOrSuperset is Exercise)
      {
        if (iterations == index)
        {
          _updateDeleteFunc(exerciseOrSuperset, onDeleteListViewCard);
          return;
        }

        iterations++;
      }
    }
  }

  void _updateDeleteFunc(Object exerciseOrSuperset,
                         Function() onDeleteListViewCard)
  {
    if (exerciseOrSuperset is Exercise)
    {
      ExerciseListViewCard exerciseListViewCard =
          exerciseOrSuperset.exerciseListViewCard;
      exerciseListViewCard.onDeleteListViewCard = onDeleteListViewCard;
    }

    else if (exerciseOrSuperset is Superset)
    {
      SupersetListViewHeader listViewHeader =
          exerciseOrSuperset.listViewHeader;
      listViewHeader.onDeleteListViewHeader = onDeleteListViewCard;
    }
  }



  @override
  String toString()
  {
    String exercisesAndSupersetsStr = _getExercisesAndSupersetsAsString();
    return 'Workout{name: $name, exercisesAndSupersets: \n$exercisesAndSupersetsStr}';
  }

  String _getExercisesAndSupersetsAsString()
  {
    String output = "[\n";

    for (Object exerciseOrSuperset in exercisesAndSupersets)
    {
      output += "\t" + exerciseOrSuperset.toString() + "\n";
    }

    output += "]";
    return output;
  }




  static Workout getDemoWorkout(Function() onDeleteListViewCard)
  {
    return Workout("Upper Body Workout", [
      Superset.notDeletable("Upper Body Bench Superset", [
        Exercise(
          "Dumbbell Bench Press",
          "DBP desc",
          onDeleteListViewCard
        ),
        Exercise(
          "Sitting Overhead Dumbbell Extension",
          "SODE Desc",
          onDeleteListViewCard
        ),
        Exercise(
          "Chest Flies",
          "CF Desc",
          onDeleteListViewCard
        ),
        Exercise(
          "Dumbbell Skull Crushers",
          "DSC Desc",
          onDeleteListViewCard
        ),
      ]),
      Exercise(
        "Break1",
        "Just take a break",
        onDeleteListViewCard
      ),
      Superset.notDeletable("Back Superset",[
        Exercise(
          "Good Morning",
          "GM Desc",
          onDeleteListViewCard
        ),
        Exercise(
          "Reverse Flyes",
          "RF Desc",
          onDeleteListViewCard
        ),
      ]),
      Superset.notDeletable("Biceps Superset",[
        Exercise(
          "Alternating Bicep Curls",
          "ABC Desc",
          onDeleteListViewCard
        ),
        Exercise(
          "Alternating Hammer Curls",
          "AHC Desc",
          onDeleteListViewCard
        ),
      ]),
      Superset.notDeletable("Shoulders Superset",[
        Exercise(
          "Military Press",
          "MP Desc",
          onDeleteListViewCard
        ),
        Exercise(
          "Front Dumbbell Raise",
          "FDR Desc",
          onDeleteListViewCard
        ),
      ]),
      Exercise(
        "Break2",
        "Just take a break",
        onDeleteListViewCard
      ),
    ]);
  }
}
