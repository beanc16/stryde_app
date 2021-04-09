enum ExerciseMuscleTypeEnum
{
  COMPOUND,
  ISOLATION
}



extension ExerciseMuscleTypeEnumHelpers on ExerciseMuscleTypeEnum
{
  static ExerciseMuscleTypeEnum getFromString(String str)
  {
    if (str == "Compound")
    {
      return ExerciseMuscleTypeEnum.COMPOUND;
    }

    else if (str == "Isolation")
    {
      return ExerciseMuscleTypeEnum.ISOLATION;
    }

    return ExerciseMuscleTypeEnum.ISOLATION;
  }

  int getId()
  {
    if (this == ExerciseMuscleTypeEnum.COMPOUND)
    {
      return 1;
    }

    else if (this == ExerciseMuscleTypeEnum.ISOLATION)
    {
      return 2;
    }

    return -1;
  }


  String toStringShort()
  {
    if (this == ExerciseMuscleTypeEnum.COMPOUND)
    {
      return "Compound";
    }

    else if (this == ExerciseMuscleTypeEnum.ISOLATION)
    {
      return "Isolation";
    }

    return this.toString().split(".").last;
  }
}
