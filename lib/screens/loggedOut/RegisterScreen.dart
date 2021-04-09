import 'package:Stryde/components/formHelpers/elements/text/LabeledTextInputElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/widgets/StrydeProgressIndicator.dart';
import 'package:Stryde/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
import 'package:Stryde/components/strydeHelpers/widgets/text/StrydeErrorText.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidget.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidgetMap.dart';
import 'package:Stryde/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:Stryde/screens/loggedIn/HomeScreen.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'package:Stryde/utilities/TextHelpers.dart';
import 'package:Stryde/utilities/UiHelpers.dart';
import 'package:Stryde/utilities/HttpQueryHelper.dart';

class RegisterScreen extends StatelessWidget
{
  late final LabeledTextInputElement _usernameInput;
  late final LabeledTextInputElement _passwordInput;
  late ToggleableWidgetMap<String> _toggleableWidgets;


  RegisterScreen()
  {
    _usernameInput = LabeledTextInputElement(
      labelText: "Username",
      placeholderText: "Enter Username",
    );
    _passwordInput = LabeledTextInputElement.password(
      labelText: "Password",
      placeholderText: "Enter password",
    );
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
    return (_usernameInput.inputText.length > 0 &&
            _passwordInput.inputText.length > 0);
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
          _toggleableWidgets.get("queryError")!
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _toggleableWidgets.get("inputValidationError")!
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
      "username": this._usernameInput.inputText,
      "password": this._passwordInput.inputText,
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
