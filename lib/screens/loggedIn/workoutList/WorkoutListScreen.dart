import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/utilities/NavigatorHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';
import 'CreateEditExerciseScreen.dart';


class WorkoutListScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return getRaisedButton(
      "Create Edit Exercise", 24, ()
      {
        navigateToScreen(context, () => CreateEditExerciseScreen());
      }
    );
  }
}