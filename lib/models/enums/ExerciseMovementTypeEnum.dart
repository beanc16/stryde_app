enum ExerciseMovementTypeEnum
{
  HORIZONTAL_PUSH,
  HORIZONTAL_PULL,
  VERTICAL_PUSH,
  VERTICAL_PULL,
  QUAD_DOMINANT,
  HIP_HAMSTRING_DOMINANT,
  ELBOW_FLEXION,
  ELBOW_EXTENSION,
  ACCESSORY_MOVEMENTS,
}



extension ExerciseMovementTypeEnumHelpers on ExerciseMovementTypeEnum
{
  static ExerciseMovementTypeEnum getFromString(String str)
  {
    if (str == "Horizontal Push")
    {
      return ExerciseMovementTypeEnum.HORIZONTAL_PUSH;
    }

    else if (str == "Horizontal Pull")
    {
      return ExerciseMovementTypeEnum.HORIZONTAL_PULL;
    }

    else if (str == "Vertical Push")
    {
      return ExerciseMovementTypeEnum.VERTICAL_PUSH;
    }

    else if (str == "Vertical Pull")
    {
      return ExerciseMovementTypeEnum.VERTICAL_PULL;
    }

    else if (str == "Quad Dominant")
    {
      return ExerciseMovementTypeEnum.QUAD_DOMINANT;
    }

    else if (str == "Hip/Hamstring Dominant" ||
             str == "Hip / Hamstring Dominant")
    {
      return ExerciseMovementTypeEnum.HIP_HAMSTRING_DOMINANT;
    }

    else if (str == "Elbow Flexion")
    {
      return ExerciseMovementTypeEnum.ELBOW_FLEXION;
    }

    else if (str == "Elbow Extension")
    {
      return ExerciseMovementTypeEnum.ELBOW_EXTENSION;
    }

    else if (str == "Accessory Movements")
    {
      return ExerciseMovementTypeEnum.ACCESSORY_MOVEMENTS;
    }

    return ExerciseMovementTypeEnum.ACCESSORY_MOVEMENTS;
  }

  int getId()
  {
    if (this == ExerciseMovementTypeEnum.HORIZONTAL_PUSH)
    {
      return 1;
    }

    else if (this == ExerciseMovementTypeEnum.HORIZONTAL_PULL)
    {
      return 2;
    }

    else if (this == ExerciseMovementTypeEnum.VERTICAL_PUSH)
    {
      return 3;
    }

    else if (this == ExerciseMovementTypeEnum.VERTICAL_PULL)
    {
      return 4;
    }

    else if (this == ExerciseMovementTypeEnum.QUAD_DOMINANT)
    {
      return 5;
    }

    else if (this == ExerciseMovementTypeEnum.HIP_HAMSTRING_DOMINANT)
    {
      return 6;
    }

    else if (this == ExerciseMovementTypeEnum.ELBOW_FLEXION)
    {
      return 7;
    }

    else if (this == ExerciseMovementTypeEnum.ELBOW_EXTENSION)
    {
      return 8;
    }

    else if (this == ExerciseMovementTypeEnum.ACCESSORY_MOVEMENTS)
    {
      return 9;
    }

    return -1;
  }


  String toStringShort()
  {
    if (this == ExerciseMovementTypeEnum.HORIZONTAL_PUSH)
    {
      return "Horizontal Push";
    }

    else if (this == ExerciseMovementTypeEnum.HORIZONTAL_PULL)
    {
      return "Horizontal Pull";
    }

    else if (this == ExerciseMovementTypeEnum.VERTICAL_PUSH)
    {
      return "Vertical Push";
    }

    else if (this == ExerciseMovementTypeEnum.VERTICAL_PULL)
    {
      return "Vertical Pull";
    }

    else if (this == ExerciseMovementTypeEnum.QUAD_DOMINANT)
    {
      return "Quad Dominant";
    }

    else if (this == ExerciseMovementTypeEnum.HIP_HAMSTRING_DOMINANT)
    {
      return "Hip/Hamstring Dominant";
    }

    else if (this == ExerciseMovementTypeEnum.ELBOW_FLEXION)
    {
      return "Elbow Flexion";
    }

    else if (this == ExerciseMovementTypeEnum.ELBOW_EXTENSION)
    {
      return "Elbow Extension";
    }

    else if (this == ExerciseMovementTypeEnum.ACCESSORY_MOVEMENTS)
    {
      return "Accessory Movements";
    }

    return this.toString().split(".").last;
  }
}
