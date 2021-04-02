import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/buttons/StrydeButton.dart';
import 'package:workout_buddy/components/colors/StrydeColors.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/strydeHelpers/StrydeUserStorage.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/StrydeProgressIndicator.dart';
import 'package:workout_buddy/components/toggleables/ToggleableWidget.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/models/UserExperience.dart';
import 'package:workout_buddy/screens/loggedOut/StartupScreen.dart';
import 'package:workout_buddy/utilities/HttpQueryHelper.dart';
import 'package:workout_buddy/utilities/NavigateTo.dart';
import 'package:workout_buddy/utilities/TextHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';


class UserProfileScreen extends StatelessWidget
{
  UserExperience _user;
  LabeledTextInputElement _goalInput;
  ToggleableWidget _goalSuccessMessage;
  ToggleableWidget _goalQueryErrorMessage;
  ToggleableWidget _goalValidationErrorMessage;
  String _curSavedGoal = "";

  UserProfileScreen()
  {
    _user = StrydeUserStorage.userExperience;
    _goalInput = LabeledTextInputElement.textArea("Goal", "Enter goal");

    if (_user.goal != null)
    {
      _goalInput.setInputText(_user.goal);
      _curSavedGoal = _user.goal;
    }

    _goalSuccessMessage = _getGoalSuccessMessage();
    _goalQueryErrorMessage = _getGoalQueryErrorMessage();
    _goalValidationErrorMessage = _getGoalValidationErrorMessage();
  }



  ToggleableWidget _getGoalSuccessMessage()
  {
    return ToggleableWidget(
      hideAllChildren: true,

      loadingIndicator: Column(
        children: [
          StrydeProgressIndicator(),
          getDefaultPadding(),
        ],
      ),

      child: Column(
        children: [
          Text(
            "Goal Successfully Saved",
            style: TextStyle(
              color: Color.fromRGBO(0, 139, 0, 1),  // Dark green
              fontSize: 16,
            ),
          ),
          getDefaultPadding(),
        ],
      ),
    );
  }

  ToggleableWidget _getGoalQueryErrorMessage()
  {
    return ToggleableWidget(
      hideAllChildren: true,
      showLoadingIndicatorOnLoading: false,

      child: Column(
        children: [
          Text(
            "Goal Failed to Save",
            style: TextStyle(
              color: Color.fromRGBO(139, 0, 0, 1),  // Dark red
              fontSize: 16,
            ),
          ),
          getDefaultPadding(),
        ],
      ),
    );
  }

  ToggleableWidget _getGoalValidationErrorMessage()
  {
    return ToggleableWidget(
      hideAllChildren: true,
      showLoadingIndicatorOnLoading: false,

      child: Column(
        children: [
          Text(
            "Must change goal before saving",
            style: TextStyle(
              color: Color.fromRGBO(139, 0, 0, 1),  // Dark red
              fontSize: 16,
            ),
          ),
          getDefaultPadding(),
        ],
      ),
    );
  }

  bool _goalHasBeenChanged()
  {
    return (_curSavedGoal != _goalInput.getInputText());
  }



  Future<void> _saveGoal() async
  {
    Map<String, String> postData = {
      "userId": StrydeUserStorage.userExperience.id.toString(),
      "userGoal": this._goalInput.getInputText(),
    };

    if (_goalHasBeenChanged())
    {
      await HttpQueryHelper.post(
        "/user/update/goal",
        postData,
        onBeforeQuery: () => _onBeforeSaveGoal(),
        onSuccess: (dynamic response) => _onSaveGoalSuccess(response),
        onFailure: (dynamic response) => _onSaveGoalFail(response)
      );
    }

    else
    {
      _onValidationFail();
    }
  }

  void _onBeforeSaveGoal()
  {
    _goalQueryErrorMessage.hideChildAndLoadingIcon();
    _goalValidationErrorMessage.hideChildAndLoadingIcon();
    _goalSuccessMessage.showLoadingIcon();
  }

  void _onSaveGoalSuccess(dynamic response) async
  {
    // Display success message
    _goalSuccessMessage.showChild();

    // Update local storage of goal
    StrydeUserStorage.userExperience.goal = this._goalInput.getInputText();
    _curSavedGoal = this._goalInput.getInputText();

    // Hide success msg after the given number of seconds
    await Future.delayed(const Duration(seconds: 3));
    _goalSuccessMessage.hideChildAndLoadingIcon();
  }

  void _onSaveGoalFail(dynamic response)
  {
    _goalSuccessMessage.hideChildAndLoadingIcon();
    _goalQueryErrorMessage.showChild();
    print("Failed to save goal:\n" + response.toString());
  }

  void _onValidationFail() async
  {
    _goalSuccessMessage.hideChildAndLoadingIcon();
    _goalQueryErrorMessage.hideChildAndLoadingIcon();
    _goalValidationErrorMessage.showChild();

    // Hide error msg after the given number of seconds
    await Future.delayed(const Duration(seconds: 3));
    _goalValidationErrorMessage.hideChildAndLoadingIcon();
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

          _goalSuccessMessage,
          _goalQueryErrorMessage,
          _goalValidationErrorMessage,

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