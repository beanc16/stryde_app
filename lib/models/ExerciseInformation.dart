class ExerciseInformation
{
  int userExerciseId;
  String? description;
  int? sets;
  int? reps;
  int? weight;
  String? duration;
  String? distance;
  String? resistance;

  ExerciseInformation({
    this.userExerciseId = -1,
    this.description,
    this.sets,
    this.reps,
    this.weight,
    this.duration,
    this.distance,
    this.resistance,
  });

  ExerciseInformation.copy(ExerciseInformation info) :
    this(
      userExerciseId: info.userExerciseId,
      description: info.description,
      sets: info.sets,
      reps: info.reps,
      weight: info.weight,
      duration: info.duration,
      distance: info.distance,
      resistance: info.resistance,
    );



  void update({
    int? userExerciseId,
    String? description,
    int? sets,
    int? reps,
    int? weight,
    String? duration,
    String? resistance,
  })
  {
    if (userExerciseId != null)
    {
      this.userExerciseId = userExerciseId;
    }

    if (description != null)
    {
      this.description = description;
    }

    if (sets != null)
    {
      this.sets = sets;
    }

    if (reps != null)
    {
      this.reps = reps;
    }

    if (weight != null)
    {
      this.weight = weight;
    }

    if (duration != null)
    {
      this.duration = duration;
    }

    if (resistance != null)
    {
      this.resistance = resistance;
    }
  }


  @override
  String toString()
  {
    return 'ExerciseInformation{'
              'userExerciseId: $userExerciseId, '
              'description: $description, sets: $sets, reps: $reps, '
              'weight: $weight, duration: $duration, '
              'distance: $distance, resistance: $resistance}';
  }
}