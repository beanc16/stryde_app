import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/buttons/StrydeButton.dart';
import 'package:workout_buddy/components/colors/StrydeColors.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/screens/loggedIn/HomeScreen.dart';
import 'package:workout_buddy/utilities/NavigatorHelpers.dart';
import 'package:workout_buddy/utilities/TextHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';
import 'package:workout_buddy/utilities/httpQueryHelpers.dart';


class LoginScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return LoginScreenState();
  }
}



class LoginScreenState extends State<LoginScreen>
{
  LabeledTextInputElement _usernameInput;
  LabeledTextInputElement _passwordInput;
  bool hasError;


  LoginScreenState()
  {
    _usernameInput = LabeledTextInputElement("Username", "Enter username");
    _passwordInput = LabeledTextInputElement.password("Password", "Enter password");
    hasError = false;
  }

  @override
  initState()
  {
    hasError = false;
  }



  List<Widget> _getChildren()
  {
    List<Widget> children = [
      getDefaultPadding(),

      TextHeader1("Login", color: StrydeColors.darkGray),
      getDefaultPadding(),

      this._usernameInput,
      getDefaultPadding(),

      this._passwordInput,
      getDefaultPadding(),

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StrydeButton(
            displayText: "Login", textSize: 20, onTap: _tryLogin,
          ),
        ],
      ),
      getDefaultPadding(),
    ];

    if (hasError)
    {
      children.addAll([
        TextHeader2("Failed to login"),
        getDefaultPadding(),
      ]);
    }

    return children;
  }



  void _tryLogin() async
  {
    Map<String, String> postData = {
      "username": this._usernameInput.inputElement
          .textEditingController.text,
      "password": this._passwordInput.inputElement
          .textEditingController.text,
    };

    await HttpQueryHelper.post(
      "/login",
      postData,
      onSuccess: (dynamic jsonResult) => _onLoginSuccess(jsonResult),
      onFailure: (dynamic response) => _onLoginFail(response)
    );
  }

  void _onLoginSuccess(dynamic response)
  {
    // Success
    if (response["_results"] != null)
    {
      Map<String, dynamic> userInfo = response["_results"];
      navigateToScreenWithoutBack(context, () => HomeScreen(userInfo));

      setState(()
      {
        hasError = false;
      });
    }

    // Fail
    else
    {
      _onLoginFail(response);
    }
  }

  void _onLoginFail(dynamic response)
  {
    setState(()
    {
      hasError = true;
    });
  }



  @override
  Widget build(BuildContext context)
  {
    return SinglePageScrollingWidget(
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _getChildren(),
      ),
    );
  }
}