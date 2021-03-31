enum MuscleGroupEnum
{
  CHEST,
  BACK,
  QUADRICEPS,
  HAMSTRINGS,
  GLUTES,
  SHOULDERS,
  BICEPS,
  TRICEPS,
  ABS,
  OBLIQUES,
  CALVES,
}



extension MuscleGroupEnumHelpers on MuscleGroupEnum
{
  static MuscleGroupEnum getFromString(String str)
  {
    if (str == "Chest")
    {
      return MuscleGroupEnum.CHEST;
    }

    else if (str == "Back")
    {
      return MuscleGroupEnum.BACK;
    }

    else if (str == "Quadriceps" ||
             str == "Quads")
    {
      return MuscleGroupEnum.QUADRICEPS;
    }

    else if (str == "Hamstrings" ||
             str == "Hams")
    {
      return MuscleGroupEnum.HAMSTRINGS;
    }

    else if (str == "Glutes")
    {
      return MuscleGroupEnum.GLUTES;
    }

    else if (str == "Shoulders")
    {
      return MuscleGroupEnum.SHOULDERS;
    }

    else if (str == "Biceps")
    {
      return MuscleGroupEnum.BICEPS;
    }

    else if (str == "Triceps")
    {
      return MuscleGroupEnum.TRICEPS;
    }

    else if (str == "Abs")
    {
      return MuscleGroupEnum.ABS;
    }

    else if (str == "Obliques")
    {
      return MuscleGroupEnum.OBLIQUES;
    }

    else if (str == "Calves")
    {
      return MuscleGroupEnum.CALVES;
    }

    return null;
  }

  int getId()
  {
    if (this == MuscleGroupEnum.CHEST)
    {
      return 1;
    }

    else if (this == MuscleGroupEnum.BACK)
    {
      return 2;
    }

    else if (this == MuscleGroupEnum.QUADRICEPS)
    {
      return 3;
    }

    else if (this == MuscleGroupEnum.HAMSTRINGS)
    {
      return 4;
    }

    else if (this == MuscleGroupEnum.GLUTES)
    {
      return 5;
    }

    else if (this == MuscleGroupEnum.SHOULDERS)
    {
      return 6;
    }

    else if (this == MuscleGroupEnum.BICEPS)
    {
      return 7;
    }

    else if (this == MuscleGroupEnum.TRICEPS)
    {
      return 8;
    }

    else if (this == MuscleGroupEnum.ABS)
    {
      return 10;
    }

    else if (this == MuscleGroupEnum.OBLIQUES)
    {
      return 11;
    }

    else if (this == MuscleGroupEnum.CALVES)
    {
      return 12;
    }

    return -1;
  }


  String toStringShort()
  {
    if (this == MuscleGroupEnum.CHEST)
    {
      return "Chest";
    }

    else if (this == MuscleGroupEnum.BACK)
    {
      return "Back";
    }

    else if (this == MuscleGroupEnum.QUADRICEPS)
    {
      return "Quadriceps";
    }

    else if (this == MuscleGroupEnum.HAMSTRINGS)
    {
      return "Hamstrings";
    }

    else if (this == MuscleGroupEnum.GLUTES)
    {
      return "Glutes";
    }

    else if (this == MuscleGroupEnum.SHOULDERS)
    {
      return "Shoulders";
    }

    else if (this == MuscleGroupEnum.BICEPS)
    {
      return "Biceps";
    }

    else if (this == MuscleGroupEnum.TRICEPS)
    {
      return "Triceps";
    }

    else if (this == MuscleGroupEnum.ABS)
    {
      return "Abs";
    }

    else if (this == MuscleGroupEnum.OBLIQUES)
    {
      return "Obliques";
    }

    else if (this == MuscleGroupEnum.CALVES)
    {
      return "Calves";
    }

    return this.toString().split(".").last;
  }
}
