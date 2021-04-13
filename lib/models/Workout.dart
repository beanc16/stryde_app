import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:Stryde/models/Exercise.dart';
import 'Superset.dart';



class Workout
{
  late final int workoutId;
  late final int userId;
  late final String name;
  late String description;
  late final List<Object> exercisesAndSupersets;
  late bool isReorderable = true;

  Workout(this.name, this.exercisesAndSupersets,
          {int workoutId = -1,
           int userId = -1,
           String description = ""})
  {
    this.workoutId = workoutId;
    this.description = description;

    if (userId == -1)
    {
      this.userId = StrydeUserStorage.userExperience?.id ?? -1;
    }
    else
    {
      this.userId = userId;
    }
  }

  Workout.notReorderable(this.name, this.exercisesAndSupersets,
                         {int workoutId = -1, int userId = -1,
                          String description = ""})
  {
    this.isReorderable = false;
    this.workoutId = workoutId;
    this.userId = userId;
    this.description = description;
  }

  Workout.duplicate(Workout workout) :
    this.notReorderable(workout.name, workout.exercisesAndSupersets,
                        workoutId: workout.workoutId,
                        userId: workout.userId,
                        description: workout.description);



  void addExerciseOrSuperset(Object obj)
  {
    if (obj is Exercise || obj is Superset)
    {
      this.exercisesAndSupersets.add(obj);
    }

    else
    {
      String objTypeStr = obj.runtimeType.toString();
      print("\nWARNING: Tried to add an object of type " + objTypeStr +
            " to a workout. But, only Exercises and Supersets can" +
            " be added.");
    }
  }

  void addExercisesOrSupersets(List<Object> objs)
  {
    for (int i = 0; i < objs.length; i++)
    {
      this.addExerciseOrSuperset(objs[i]);
    }
  }

  void insertExerciseOrSuperset(Object obj, int index)
  {
    if (obj is Exercise || obj is Superset)
    {
      this.exercisesAndSupersets.insert(index, obj);
    }

    else
    {
      String objTypeStr = obj.runtimeType.toString();
      print("\nWARNING: Tried to insert an object of type " + objTypeStr +
            " to a workout. But, only Exercises and Supersets can" +
            " be added.");
    }
  }

  Workout duplicate()
  {
    return Workout.duplicate(this);
  }



  bool hasNoExercisesOrSupersets()
  {
    return exercisesAndSupersets.length == 0;
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
            //key: Key("Divider ${numOfDividers++}"),
            key: UniqueKey(),
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
            //key: Key("Divider ${numOfDividers++}"),
            key: UniqueKey(),
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
          //key: Key("Divider ${numOfDividers++}"),
          key: UniqueKey(),
          thickness: 3,
          color: Colors.black38
        ));
         */
      }
    }

    return children;
  }

  ListView getAsListView()
  {
    List<Widget> exercisesAndSupersetsListViewCardsAndHeaders =
      this.getAsWidgets();
    print("exercisesAndSupersetsListViewCardsAndHeaders: " +
              exercisesAndSupersetsListViewCardsAndHeaders.toString());

    if (exercisesAndSupersetsListViewCardsAndHeaders.length == 0)
    {
      print("length is 0");
      return ListView(
        key: Key(this.name),
        children: [],
        shrinkWrap: true,
      );
    }
    print("length is NOT 0 (good news)");

    return ListView.builder(
      //key: Key(this.name),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index)
      {
        return exercisesAndSupersetsListViewCardsAndHeaders[index];
      }
    );

    /*
    return ListView(
      key: Key(this.name),
      children: exercisesAndSupersetsListViewCardsAndHeaders,
      shrinkWrap: true,
    );
     */
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

  void updateOnTapFunc(Function(BuildContext, dynamic) onTap)
  {
    for (Object exerciseOrSuperset in exercisesAndSupersets)
    {
      if (exerciseOrSuperset is Superset)
      {
        // Update superset's onTap
        _updateOnTapFunc(exerciseOrSuperset, onTap);

        // Update each superset exercise's onTap
        for (Exercise exercise in exerciseOrSuperset.exercises)
        {
          _updateOnTapFunc(exercise, onTap);
        }
      }

      // Update exercise's onTap
      else if (exerciseOrSuperset is Exercise)
      {
        _updateOnTapFunc(exerciseOrSuperset, onTap);
      }
    }
  }

  void _updateOnTapFunc(Object exerciseOrSuperset,
                        Function(BuildContext, dynamic) onTap)
  {
    if (exerciseOrSuperset is Exercise)
    {
      ExerciseListViewCard exerciseListViewCard =
          exerciseOrSuperset.exerciseListViewCard;
      exerciseListViewCard.onTap = onTap;
    }

    else if (exerciseOrSuperset is Superset)
    {
      SupersetListViewHeader listViewHeader =
          exerciseOrSuperset.listViewHeader;
      // TODO: Add onTap to superset headers
      //listViewHeader.onTap = onTap;
    }
  }



  @override
  String toString()
  {
    String exercisesAndSupersetsStr = _getExercisesAndSupersetsAsString();
    return 'Workout{name: "$name", description: "$description", ' +
                   'workoutId: $workoutId, userId: $userId, ' +
                   'exercisesAndSupersets: \n$exercisesAndSupersetsStr}';
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


  @override
  bool operator ==(Object other)
  =>
      identical(this, other) ||
          other is Workout &&
              runtimeType == other.runtimeType &&
              workoutId == other.workoutId &&
              userId == other.userId &&
              name == other.name &&
              description == other.description &&
              exercisesAndSupersets == other.exercisesAndSupersets &&
              isReorderable == other.isReorderable;

  @override
  int get hashCode
  =>
      workoutId.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      exercisesAndSupersets.hashCode ^
      isReorderable.hashCode;

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
