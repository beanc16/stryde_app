import 'dart:async';
import 'package:Stryde/components/formHelpers/elements/text/LabeledTextInputElement.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooLongException.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooShortException.dart';
import 'package:Stryde/components/strydeHelpers/widgets/toggleableWidgets/StrydeErrorToggleableWidget.dart';
import 'package:Stryde/components/strydeHelpers/widgets/toggleableWidgets/StrydeSuccessToggleableWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:Stryde/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
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
      maxInputLength: 45,
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
      "successMsg": StrydeSuccessToggleableWidget(
        showLoadingIndicatorOnLoading: true,
        successMsg: "Goal Successfully Saved",
      ),
      "queryErrorMsg": StrydeErrorToggleableWidget(
        errorMsg: "Goal Failed to Save",
      ),
      "validationErrorMsg": StrydeErrorToggleableWidget(
        errorMsg: "Must change goal before saving",
      ),
      "inputTooShortError": StrydeErrorToggleableWidget(
        errorMsg: "Goal is too short",
      ),
      "inputTooLongError": StrydeErrorToggleableWidget(
        errorMsg: "Goal is too long",
      ),
    });
  }

  bool _isInputValid()
  {
    bool result = true;

    if (_goalInput.isValidInput() && _goalHasBeenChanged())
    {
      _goalInput.showBorder = false;
    }
    else
    {
      _goalInput.showBorder = true;
      result = false;
    }

    return result;
  }

  void _tryThrowExceptions()
  {
    try
    {
      if (!_goalHasBeenChanged())
      {
        _toggleableWidgets.hideAllExcept("inputTooLongError");
        _toggleableWidgets.showChildFor(
          "validationErrorMsg", Duration(seconds: 3,)
        );
        return;
      }
      _goalInput.tryThrowExceptionMessage();
    }

    on InputTooLongException catch (ex)
    {
      _toggleableWidgets.hideAllExcept("inputTooLongError");
      _toggleableWidgets.showChildFor(
        "inputTooLongError", Duration(seconds: 3,)
      );
    }

    on InputTooShortException catch (ex)
    {
      _toggleableWidgets.hideAllExcept("inputTooShortError");
      _toggleableWidgets.showChildFor(
        "inputTooShortError", Duration(seconds: 3,)
      );
    }

    on Exception catch (ex)
    {
      _toggleableWidgets.hideAllExcept("queryErrorMsg");
      _toggleableWidgets.showChildFor(
        "queryErrorMsg", Duration(seconds: 3,)
      );
    }
  }



  bool _goalHasBeenChanged()
  {
    return (_curSavedGoal != _goalInput.inputText.trim());
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

          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: _goalInput,
          ),

          // Error messages
          _toggleableWidgets,

          StrydeButton(
            displayText: "Save Goal",
            textSize: 20,
            onTap: ()
            {
              if (_isInputValid())
              {
                _saveGoal();
              }
              else
              {
                _tryThrowExceptions();
              }
            },
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