import 'dart:async';
import 'package:Stryde/components/formHelpers/elements/text/LabeledTextInputElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:Stryde/components/strydeHelpers/widgets/StrydeProgressIndicator.dart';
import 'package:Stryde/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
import 'package:Stryde/components/strydeHelpers/widgets/text/StrydeErrorText.dart';
import 'package:Stryde/components/strydeHelpers/widgets/text/StrydeSuccessText.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidget.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidgetMap.dart';
import 'package:Stryde/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:Stryde/models/UserExperience.dart';
import 'package:Stryde/screens/loggedOut/StartupScreen.dart';
import 'package:Stryde/utilities/HttpQueryHelper.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'package:Stryde/utilities/TextHelpers.dart';
import 'package:Stryde/utilities/UiHelpers.dart';


class UserProfileScreen extends StatelessWidget
{
  late UserExperience? _user;
  late LabeledTextInputElement _goalInput;
  late ToggleableWidgetMap<String> _toggleableWidgets;
  late String? _curSavedGoal = "";

  UserProfileScreen()
  {
  _user = StrydeUserStorage.userExperience;
  _goalInput = LabeledTextInputElement.textArea(
    labelText: "Goal",
    placeholderText: "Enter goal",
  );

    if (_user != null)
    {
      if (_user?.goal != null)
      {
        _goalInput.inputText = _user?.goal ?? "";
        _curSavedGoal = _user?.goal ?? "";
      }
    }

    _toggleableWidgets = ToggleableWidgetMap({
      "successMsg": _getGoalSuccessMessage(),
      "queryErrorMsg": _getGoalQueryErrorMessage(),
      "validationErrorMsg": _getGoalValidationErrorMessage(),
    });
  }



  ToggleableWidget _getGoalSuccessMessage()
  {
    return ToggleableWidget(
      hideOnStartup: true,

      loadingIndicator: Column(
        children: [
          StrydeProgressIndicator(),
          getDefaultPadding(),
        ],
      ),

      child: Column(
        children: [
          StrydeSuccessText(displayText: "Goal Successfully Saved"),
          getDefaultPadding(),
        ],
      ),
    );
  }

  ToggleableWidget _getGoalQueryErrorMessage()
  {
    return ToggleableWidget(
      hideOnStartup: true,
      showLoadingIndicatorOnLoading: false,

      child: Column(
        children: [
          StrydeErrorText(displayText: "Goal Failed to Save"),
          getDefaultPadding(),
        ],
      ),
    );
  }

  ToggleableWidget _getGoalValidationErrorMessage()
  {
    return ToggleableWidget(
      hideOnStartup: true,
      showLoadingIndicatorOnLoading: false,

      child: Column(
        children: [
          StrydeErrorText(displayText: "Must change goal before " +
                                       "saving"),
          getDefaultPadding(),
        ],
      ),
    );
  }

  bool _goalHasBeenChanged()
  {
    return (_curSavedGoal != _goalInput.inputText);
  }



  Future<void> _saveGoal() async
  {
    Map<String, String?> postData = {
      "userId": StrydeUserStorage.userExperience?.id.toString(),
      "userGoal": this._goalInput.inputText,
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
    _toggleableWidgets.hideChildAndLoadingIcon("queryErrorMsg");
    _toggleableWidgets.hideChildAndLoadingIcon("validationErrorMsg");
    _toggleableWidgets.showLoadingIcon("successMsg");
  }

  void _onSaveGoalSuccess(dynamic response) async
  {
    // Display success message
    _toggleableWidgets.showChild("successMsg");

    // Update local storage of goal
    StrydeUserStorage.userExperience?.goal = this._goalInput.inputText;
    _curSavedGoal = this._goalInput.inputText;

    // Hide success msg after the given number of seconds
    _toggleableWidgets.hideChildAndLoadingIconAfter(
      "successMsg", const Duration(seconds: 3)
    );
  }

  void _onSaveGoalFail(dynamic response)
  {
    _toggleableWidgets.hideChildAndLoadingIcon("successMsg");
    _toggleableWidgets.showChild("queryErrorMsg");
  }

  void _onValidationFail() async
  {
    _toggleableWidgets.hideChildAndLoadingIcon("successMsg");
    _toggleableWidgets.hideChildAndLoadingIcon("queryErrorMsg");
    _toggleableWidgets.showChild("validationErrorMsg");

    // Hide error msg after the given number of seconds
    _toggleableWidgets.hideChildAndLoadingIconAfter(
      "validationErrorMsg", const Duration(seconds: 3)
    );
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
              displayText: _user?.username ?? "",
              color: StrydeColors.darkGray,
            ),
          ),
          getDefaultPadding(),

          _goalInput,
          getDefaultPadding(),

          // successMsg, queryErrorMsg, validationErrorMsg
          _toggleableWidgets.get("successMsg")!,
          _toggleableWidgets.get("queryErrorMsg")!,
          _toggleableWidgets.get("validationErrorMsg")!,

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