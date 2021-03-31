enum ExerciseWeightTypeEnum
{
  FREE_WEIGHT,
  BODY_WEIGHT,
  MACHINE,
}



extension ExerciseWeightTypeEnumHelpers on ExerciseWeightTypeEnum
{
  static ExerciseWeightTypeEnum getFromString(String str)
  {
    if (str == "Free Weight")
    {
      return ExerciseWeightTypeEnum.FREE_WEIGHT;
    }

    else if (str == "Body Weight")
    {
      return ExerciseWeightTypeEnum.BODY_WEIGHT;
    }

    else if (str == "Machine")
    {
      return ExerciseWeightTypeEnum.MACHINE;
    }

    return null;
  }

  int getId()
  {
    if (this == ExerciseWeightTypeEnum.FREE_WEIGHT)
    {
      return 1;
    }

    else if (this == ExerciseWeightTypeEnum.BODY_WEIGHT)
    {
      return 2;
    }

    else if (this == ExerciseWeightTypeEnum.MACHINE)
    {
      return 3;
    }

    return -1;
  }


  String toStringShort()
  {
    if (this == ExerciseWeightTypeEnum.FREE_WEIGHT)
    {
      return "Free Weight";
    }

    else if (this == ExerciseWeightTypeEnum.BODY_WEIGHT)
    {
      return "Body Weight";
    }

    else if (this == ExerciseWeightTypeEnum.MACHINE)
    {
      return "Machine";
    }

    return this.toString().split(".").last;
  }
}
