import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/utilities/FormHelpers.dart';
import 'package:workout_buddy/utilities/TextHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';

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
    if (!hasError)
    {
      return [
        getPadding(10),

        TextHeader1("Register"),
        getDefaultPadding(),

        this._usernameInput,
        getPadding(30),

        this._passwordInput,
        getPadding(30),

        getRaisedButton(
          "Register",
          48,
          ()  // Callback
          {
            if (this._usernameInput.inputElement.textEditingController.text.length <= 0 ||
                this._passwordInput.inputElement.textEditingController.text.length <= 0 ||
                this._usernameInput.inputElement.textEditingController.text == "" ||
                this._passwordInput.inputElement.textEditingController.text == "")
            {
              setState(()
              {
                hasError = true;
              });
              return;
            }

            Map<String, String> postData = {
              "username": this._usernameInput.inputElement.textEditingController.text,
              "password": this._passwordInput.inputElement.textEditingController.text,
            };

            /*
            http.post("http://159.89.55.211:4444/register", body: postData)
                .then((response)
                {
                  // Success
                  if (response.body != "error")
                  {
                    Map<String, dynamic> loggedInUserInfo = jsonDecode(response.body);
                    int userId = loggedInUserInfo["insertId"];
                    navigateToScreenWithoutBack(context, () => HomeScreen(userId));

                    setState(()
                             {
                               hasError = false;
                             });
                  }

                  // Error
                  else
                  {
                    setState(()
                             {
                               hasError = true;
                             });
                  }
                });
              */
          }), // Callback
        getDefaultPadding(),
      ];
    }

    else
    {
      return [
        getPadding(10),

        TextHeader1("Register"),
        getDefaultPadding(),

        this._usernameInput,
        getPadding(30),

        this._passwordInput,
        getPadding(30),

        getRaisedButton(
          "Register",
          48,
          ()
          {
            if (this._usernameInput.inputElement.textEditingController.text.length <= 0 ||
                this._passwordInput.inputElement.textEditingController.text.length <= 0 ||
                this._usernameInput.inputElement.textEditingController.text == "" ||
                this._passwordInput.inputElement.textEditingController.text == "")
            {
              setState(()
                       {
                         hasError = true;
                       });
              return;
            }

            Map<String, String> postData = {
              "username": this._usernameInput.inputElement
                  .textEditingController.text,
              "password": this._passwordInput.inputElement
                  .textEditingController.text,
            };

            /*
            http.post("http://159.89.55.211:4444/register", body: postData)
                .then((response)
                {
                  // Success
                  if (response.body != "error")
                  {
                    Map<String, dynamic> loggedInUserInfo = jsonDecode(response.body);
                    int userId = loggedInUserInfo["insertId"];
                    navigateToScreenWithoutBack(context, () => HomeScreen(userId));

                    setState(()
                             {
                               hasError = false;
                             });
                  }

                  // Error
                  else
                  {
                    setState(()
                    {
                      hasError = true;
                    });
                  }
                });
             */
          }
        ),
        getDefaultPadding(),

        TextHeader2("Failed to register"),
        getDefaultPadding(),
      ];
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return SinglePageScrollingWidget(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: getChildren(),
        )
    );
  }
}
