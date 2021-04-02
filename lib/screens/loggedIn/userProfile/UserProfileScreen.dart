import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/buttons/StrydeButton.dart';
import 'package:workout_buddy/components/colors/StrydeColors.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/strydeHelpers/StrydeUserStorage.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/models/UserExperience.dart';
import 'package:workout_buddy/screens/loggedOut/StartupScreen.dart';
import 'package:workout_buddy/utilities/NavigateTo.dart';
import 'package:workout_buddy/utilities/TextHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';


class UserProfileScreen extends StatelessWidget
{
  UserExperience _user;
  TextInputElement _goalInput;

  UserProfileScreen()
  {
    _user = StrydeUserStorage.userExperience;
    _goalInput = TextInputElement.textArea("Enter goal");

    if (_user.goal != null)
    {
      _goalInput.setInputText(_user.goal);
    }
  }



  void _saveGoal()
  {
    print("Save goal");
  }

  void _logOut(BuildContext context)
  {
    StrydeUserStorage.reset();
    NavigateTo.screenWithoutBack(context, () => StartupScreen());
  }



  @override
  Widget build(BuildContext context)
  {
    return SinglePageScrollingWidget(
      marginAroundScreens: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getDefaultPadding(),

          Center(
            child: TextHeader1(
              displayText: _user.username,
              color: StrydeColors.darkGray,
            ),
          ),
          getDefaultPadding(),

          _goalInput,
          getDefaultPadding(),

          StrydeButton(
            displayText: "Save Goal",
            textSize: 20,
            onTap: () => _saveGoal(),
          ),
          getDefaultPadding(),

          StrydeButton(
            displayText: "Logout",
            textSize: 20,
            onTap: () => _logOut(context),
          ),
          getDefaultPadding(),
        ],
      ),
    );
  }
}