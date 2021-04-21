import 'dart:convert';
import 'package:Stryde/components/toggleableWidget/EmptyWidgetWithData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:Stryde/models/Exercise.dart';
import 'Superset.dart';



class Workout
{
  late final int workoutId;
  late final int userId;
  String name;
  String description;
  late final List<Object> exercisesAndSupersets;
  late bool isReorderable = true;

  Workout(this.name, this.exercisesAndSupersets,
          {int workoutId = -1,
           int userId = -1,
           this.description = ""})
  {
    this.workoutId = workoutId;

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
                          this.description = ""})
  {
    this.isReorderable = false;
    this.workoutId = workoutId;
    this.userId = userId;
    this.description = description;
  }



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
      if (index >= this.exercisesAndSupersets.length)
      {
        index = this.exercisesAndSupersets.length;
      }

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
    return Workout.notReorderable(
      this.name,
      this.exercisesAndSupersets.toList(),
      workoutId: this.workoutId,
      userId: this.userId,
      description: this.description,
    );
  }



  List<Exercise> getUpdatedExercises()
  {
    List<Exercise> results = [];

    for (int i = 0; i < exercisesAndSupersets.length; i++)
    {
      Object curExerciseOrSuperset = exercisesAndSupersets[i];

      if (curExerciseOrSuperset is Exercise)
      {
        results.add(curExerciseOrSuperset);
      }
    }

    return results;
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
        if (exerciseOrSuperset.wasDeleted)
        {
          children.add(EmptyWidgetWithData(data: exerciseOrSuperset));
          continue;
        }

        if (inSuperset)
        {
          inSuperset = false;
          children.add(Divider(
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

    if (exercisesAndSupersetsListViewCardsAndHeaders.length == 0)
    {
      return ListView(
        key: Key(this.name),
        children: [],
        shrinkWrap: true,
      );
    }

    return ListView.builder(
      //key: Key(this.name),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index)
      {
        return exercisesAndSupersetsListViewCardsAndHeaders[index];
      }
    );
  }

  Map<String, String> getAsJson()
  {
    // Used to update database
    Map<String, String> output = {
      "userId": StrydeUserStorage.userExperience?.id.toString() ?? "",
      "workoutId": this.workoutId.toString(),
      "workoutName": this.name.toString(),
      "workoutDescription": this.description.toString(),
    };

    List<Map<String, dynamic>> exerciseInfoToUpdate = [];
    bool exerciseWillBeDeleted = false;
    int curOrderInWorkoutOfNonDeletedExercises = 1;

    for (int i = 0; i < this.exercisesAndSupersets.length; i++)
    {
      dynamic curExerciseOrSuperset = this.exercisesAndSupersets[i];

      if (curExerciseOrSuperset is Exercise)
      {
        List<Map<String, dynamic>> curExerciseInfo =
            //curExerciseOrSuperset.getAsUpdatedJson(i + 1);
            curExerciseOrSuperset.getAsUpdatedJson(
                exerciseWillBeDeleted ? // If one or more exercises will be deleted
                curOrderInWorkoutOfNonDeletedExercises + 1 :  // Use orderInWorkout of non-deleted workouts
                i + 1                   // Use index + 1 since no exercises were deleted
            );

        bool curExerciseWasDeleted = true;
        for (int j = 0; j < curExerciseInfo.length; j++)
        {
          // The current exercise WAS NOT deleted
          if (curExerciseInfo[j]["shouldDelete"] == null ||
              curExerciseInfo[j]["shouldDelete"] == false)
          {
            curExerciseWasDeleted = false;
            break;
          }
        }

        if (curExerciseWasDeleted)
        {
          exerciseWillBeDeleted = true;
          curOrderInWorkoutOfNonDeletedExercises = curExerciseInfo[0]["orderInWorkout"] - 1;
        }
        else if (exerciseWillBeDeleted && !curExerciseWasDeleted)
        {
          curOrderInWorkoutOfNonDeletedExercises++;
        }

        if (curExerciseInfo.isNotEmpty)
        {
          exerciseInfoToUpdate.addAll(curExerciseInfo);
        }
      }
    }

    output.addAll({
      "userExerciseInfoAndOrderArray": jsonEncode(exerciseInfoToUpdate),
    });
    return output;
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

  void updateOnTapFunc(BuildContext context)
  {
    for (Object exerciseOrSuperset in exercisesAndSupersets)
    {
      if (exerciseOrSuperset is Superset)
      {
        // Update superset's onTap
        _updateOnTapFunc(exerciseOrSuperset, context);

        // Update each superset exercise's onTap
        for (Exercise exercise in exerciseOrSuperset.exercises)
        {
          _updateOnTapFunc(exercise, context);
        }
      }

      // Update exercise's onTap
      else if (exerciseOrSuperset is Exercise)
      {
        _updateOnTapFunc(exerciseOrSuperset, context);
      }
    }
  }

  void _updateOnTapFunc(Object exerciseOrSuperset,
                        BuildContext context)
  {
    if (exerciseOrSuperset is Exercise)
    {
      ExerciseListViewCard exerciseListViewCard =
          exerciseOrSuperset.exerciseListViewCard;
      exerciseListViewCard.onTap = (BuildContext c, data) =>
          exerciseOrSuperset.onTapDefault(context, exerciseOrSuperset);
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
