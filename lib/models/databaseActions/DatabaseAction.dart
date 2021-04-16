import '../ExerciseInformation.dart';
import 'DatabaseActionType.dart';


class DatabaseAction
{
  late ExerciseInformation oldInfo;
  ExerciseInformation? newInfo;
  late DatabaseActionType actionType;
  late bool hasChanged;
  
  DatabaseAction({
    required ExerciseInformation oldInfo,
    ExerciseInformation? newInfo,
    required this.actionType,
  })
  {
    this.oldInfo = oldInfo.duplicate();
    this.newInfo = newInfo;
    this.hasChanged = false;
  }



  void update({
    required ExerciseInformation newInfo,
  })
  {
    this.newInfo = newInfo.duplicate();
    this.actionType = DatabaseActionType.Update;
    this.hasChanged = true;
  }
}