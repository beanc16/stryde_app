import 'package:Stryde/models/ExerciseInformation.dart';


class ExerciseInformationRow
{
  int setNum;
  ExerciseInformation info;

  ExerciseInformationRow({
    required this.setNum,
    required this.info,
  });



  Map<dynamic, dynamic> toJson()
  {
    return {
      "setNum": setNum,
      "reps": info.reps ?? "",
      "weight": info.weight ?? "",
      "duration": info.duration ?? "",
      "resistance": info.resistance ?? "",
    };
  }
}
