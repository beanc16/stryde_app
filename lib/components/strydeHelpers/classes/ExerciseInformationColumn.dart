class ExerciseInformationColumn
{
  String title;
  String keyName;
  bool isEditable;
  double widthFactor;

  ExerciseInformationColumn({
    required this.title,
    required this.keyName,
    this.isEditable = true,
    this.widthFactor = 0.2,
  });



  Map<dynamic, dynamic> toJson()
  {
    return {
      "title": title,
      "key": keyName,
      "editable": isEditable
      //"widthFactor": widthFactor,
    };
  }
}