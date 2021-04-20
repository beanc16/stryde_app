import 'package:Stryde/components/formHelpers/elements/text/LabeledTextInputElement.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooLongException.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooShortException.dart';
import 'package:Stryde/components/strydeHelpers/widgets/toggleableWidgets/StrydeErrorToggleableWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
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
      placeholderText: "Enter username",
      minInputLength: 1,
      maxInputLength: 45,
    );
    _passwordInput = LabeledTextInputElement.password(
      labelText: "Password",
      placeholderText: "Enter password",
      minInputLength: 1,
      maxInputLength: 120,
    );
    _toggleableWidgets = ToggleableWidgetMap({
      "queryError": StrydeErrorToggleableWidget(
        errorMsg: "Registration failed (username may be taken)",
        showLoadingIndicatorOnLoading: true,
      ),
      "inputTooShortError": StrydeErrorToggleableWidget(
        errorMsg: "Username or password is too short",
      ),
      "inputTooLongError": StrydeErrorToggleableWidget(
        errorMsg: "Username or password is too long",
      ),
    });
  }

  bool _isInputValid()
  {
    bool result = true;

    if (_usernameInput.isValidInput())
    {
      _usernameInput.showBorder = false;
    }
    else
    {
      _usernameInput.showBorder = true;
      result = false;
    }

    if (_passwordInput.isValidInput())
    {
      _passwordInput.showBorder = false;
    }
    else
    {
      _passwordInput.showBorder = true;
      result = false;
    }

    return result;
  }

  void _tryThrowExceptions()
  {
    try
    {
      _usernameInput.tryThrowExceptionMessage();
      _passwordInput.tryThrowExceptionMessage();
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
      _toggleableWidgets.hideAllExcept("inputQueryError");
      _toggleableWidgets.showChildFor(
        "inputQueryError", Duration(seconds: 3,)
      );
    }
  }



  List<Widget> _getChildren(BuildContext context)
  {
    return [
      getDefaultPadding(),

      TextHeader1(displayText: "Register", color: StrydeColors.darkGray),
      getDefaultPadding(),

      this._usernameInput,

      Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: this._passwordInput,
      ),

      this._toggleableWidgets,

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StrydeButton(
            displayText: "Register", textSize: 20,
            onTap: ()
            {
              if (_isInputValid())
              {
                _tryRegister(context);
              }
              else
              {
                _tryThrowExceptions();
              }
            },
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

    await HttpQueryHelper.post(
      "/register",
      postData,
      onBeforeQuery: () => _onBeforeRegister(),
      onSuccess: (jsonResult) => _onRegisterSuccess(context, jsonResult),
      onFailure: (response) => _onRegisterFail(response)
    );
  }

  void _onBeforeRegister()
  {
    _toggleableWidgets.hideAllExcept("queryError");
    _toggleableWidgets.showLoadingIcon("queryError");
  }

  void _onRegisterSuccess(BuildContext context, dynamic response)
  {
    // Success
    if (response["_results"] != null)
    {
      Map<String, dynamic> userInfo = response["_results"];
      NavigateTo.screenWithoutBack(context, () => HomeScreen(userInfo));

      _toggleableWidgets.hideAll();
    }

    // Fail
    else
    {
      _onRegisterFail(response);
    }
  }

  void _onRegisterFail(dynamic response)
  {
    print("");
    print("");
    print("");
    print(response);
    print("");
    print("");
    print("");
    _toggleableWidgets.hideAllExcept("queryError");
    _toggleableWidgets.showChild("queryError");

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
