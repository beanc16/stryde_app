import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/screens/loggedIn/HomeScreen.dart';
import 'package:workout_buddy/utilities/NavigatorHelpers.dart';
import 'package:workout_buddy/utilities/TextHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';
import 'package:workout_buddy/utilities/httpQueryHelpers.dart';

class RegisterScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return RegisterScreenState();
  }
}



class RegisterScreenState extends State<RegisterScreen>
{
  LabeledTextInputElement _usernameInput;
  LabeledTextInputElement _passwordInput;
  bool hasError;


  RegisterScreenState()
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



  List<Widget> getChildren()
  {

    List<Widget> children = [
      getPadding(10),

      TextHeader1("Register"),
      getDefaultPadding(),

      this._usernameInput,
      getPadding(30),

      this._passwordInput,
      getPadding(30),

      getRaisedButton("Register", 48, _tryRegister),
      getDefaultPadding(),
    ];

    if (hasError)
    {
      children.addAll([
        TextHeader2("Failed to register"),
        getDefaultPadding(),
      ]);
    }

    return children;
  }



  void _tryRegister() async
  {
    Map<String, String> postData = {
      "username": this._usernameInput.inputElement
          .textEditingController.text,
      "password": this._passwordInput.inputElement
          .textEditingController.text,
    };

    await HttpQueryHelper.post(
      "/register",
      postData,
      onSuccess: (dynamic jsonResult) => _onRegisterSuccess(jsonResult),
      onFailure: (dynamic response) => _onRegisterFail(response)
    );
  }

  void _onRegisterSuccess(dynamic response)
  {
    // Success
    if (response["error"] == null && response["results"] != null)
    {
      Map<String, dynamic> userInfo = response["results"];
      navigateToScreenWithoutBack(context, () => HomeScreen(userInfo));

      setState(()
      {
        hasError = false;
      });
    }

    // Fail
    else
    {
      _onRegisterFail(response);
    }
  }

  void _onRegisterFail(dynamic response)
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
        children: getChildren(),
      ),
    );
  }
}
