import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/StrydeProgressIndicator.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/text/StrydeErrorText.dart';
import 'package:workout_buddy/components/toggleableWidget/ToggleableWidget.dart';
import 'package:workout_buddy/components/toggleableWidget/ToggleableWidgetMap.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/screens/loggedIn/HomeScreen.dart';
import 'package:workout_buddy/utilities/NavigateTo.dart';
import 'package:workout_buddy/utilities/TextHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';
import 'package:workout_buddy/utilities/HttpQueryHelper.dart';

class RegisterScreen extends StatelessWidget
{
  LabeledTextInputElement _usernameInput;
  LabeledTextInputElement _passwordInput;
  ToggleableWidgetMap<String> _toggleableWidgets;


  RegisterScreen()
  {
    _usernameInput = LabeledTextInputElement("Username", "Enter username");
    _passwordInput = LabeledTextInputElement.password("Password", "Enter password");
    _toggleableWidgets = ToggleableWidgetMap({
      "queryError": _getQueryErrorMessage(),
      "inputValidationError": _getValidationErrorMessage(),
    });
  }

  ToggleableWidget _getQueryErrorMessage()
  {
    return ToggleableWidget(
      hideOnStartup: true,
      showLoadingIndicatorOnLoading: false,

      child: Column(
        children: [
          StrydeErrorText(displayText: "Register failed (username " +
                                       "may be taken)"),
          getDefaultPadding(),
        ],
      ),
    );
  }

  ToggleableWidget _getValidationErrorMessage()
  {
    return ToggleableWidget(
      hideOnStartup: true,
      loadingIndicator: Column(
        children: [
          Padding(
            child: StrydeProgressIndicator(),
            padding: EdgeInsets.only(left: 5),
          ),
          getDefaultPadding(),
        ],
      ),

      child: Column(
        children: [
          StrydeErrorText(displayText: "Please enter a username " +
                                       "& password"),
          getDefaultPadding(),
        ],
      ),
    );
  }

  bool _usernameAndPasswordAreTyped()
  {
    return (_usernameInput.getInputText().length > 0 &&
            _passwordInput.getInputText().length > 0);
  }



  List<Widget> _getChildren(BuildContext context)
  {
    return [
      getDefaultPadding(),

      TextHeader1(displayText: "Register", color: StrydeColors.darkGray),
      getDefaultPadding(),

      this._usernameInput,
      getDefaultPadding(),

      this._passwordInput,
      getDefaultPadding(),

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _toggleableWidgets.get("queryError")
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _toggleableWidgets.get("inputValidationError")
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StrydeButton(
            displayText: "Register", textSize: 20,
            onTap: () => _tryRegister(context),
          ),
        ],
      ),
      getDefaultPadding(),
    ];
  }



  void _tryRegister(BuildContext context) async
  {
    Map<String, String> postData = {
      "username": this._usernameInput.inputElement
          .textEditingController.text,
      "password": this._passwordInput.inputElement
          .textEditingController.text,
    };


    if (!_usernameAndPasswordAreTyped())
    {
      _onUsernameAndPasswordValidationFailed();
    }

    else
    {
      await HttpQueryHelper.post(
        "/register",
        postData,
        onBeforeQuery: () => _onBeforeRegister(),
        onSuccess: (jsonResult) => _onRegisterSuccess(context, jsonResult),
        onFailure: (response) => _onRegisterFail(response)
      );
    }
  }

  void _onUsernameAndPasswordValidationFailed()
  {
    _toggleableWidgets.hideChildAndLoadingIcon("queryError");
    _toggleableWidgets.hideLoadingIcon("inputValidationError");

    _toggleableWidgets.showChildFor(
      "inputValidationError", const Duration(seconds: 3)
    );
  }

  void _onBeforeRegister()
  {
    _toggleableWidgets.hideChildAndLoadingIcon("queryError");
    _toggleableWidgets.showLoadingIcon("inputValidationError");
  }

  void _onRegisterSuccess(BuildContext context, dynamic response)
  {
    // Success
    if (response["_results"] != null)
    {
      Map<String, dynamic> userInfo = response["_results"];
      NavigateTo.screenWithoutBack(context, () => HomeScreen(userInfo));

      _toggleableWidgets.hideChildAndLoadingIcon("inputValidationError");
    }

    // Fail
    else
    {
      _onRegisterFail(response);
    }
  }

  void _onRegisterFail(dynamic response)
  {
    _toggleableWidgets.showChildOrLoadingIcon("queryError");
    _toggleableWidgets.hideChildAndLoadingIcon("inputValidationError");

    _toggleableWidgets.hideChildAndLoadingIconAfter(
      "queryError", const Duration(seconds: 3)
    );
  }



  @override
  Widget build(BuildContext context)
  {
    return SinglePageScrollingWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _getChildren(context),
      ),
    );
  }
}
