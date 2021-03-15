import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/utilities/FormHelpers.dart';

import 'package:workout_buddy/utilities/NavigatorHelpers.dart';
import 'package:workout_buddy/utilities/TextHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';


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



  List<Widget> getChildren()
  {
    if (!hasError)
    {
      return [
        getPadding(10),

        TextHeader1("Login"),
        getDefaultPadding(),

        this._usernameInput,
        getPadding(30),

        this._passwordInput,
        getPadding(30),

        getRaisedButton(
          "Login",
          48,
          ()  // Callback
          {
            Map<String, String> postData = {
              "username": this._usernameInput.inputElement
                  .textEditingController.text,
              "password": this._passwordInput.inputElement
                  .textEditingController.text,
            };

            /*
            http.post("http://159.89.55.211:4444/login", body: postData)
                .then((response)
                      {
                        // Success
                        if (response.body != "error")
                        {
                          Map<String, dynamic> loggedInUserInfo = jsonDecode(response.body);
                          int userId = loggedInUserInfo["user_id"];
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
      ];
    }

    else
    {
      return [
        getPadding(10),

        TextHeader1("Login"),
        getDefaultPadding(),

        this._usernameInput,
        getPadding(30),

        this._passwordInput,
        getPadding(30),

        getRaisedButton(
          "Login",
          48,
          ()
          {
            Map<String, String> postData = {
              "username": this._usernameInput.inputElement
                  .textEditingController.text,
              "password": this._passwordInput.inputElement
                  .textEditingController.text,
            };

            /*
            http.post("http://159.89.55.211:4444/login", body: postData)
                .then((response)
                {
                  // Success
                  if (response.body != "error")
                  {
                    Map<String, dynamic> loggedInUserInfo = jsonDecode(response.body);
                    int userId = loggedInUserInfo["user_id"];
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
        TextHeader2("Failed to login"),
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