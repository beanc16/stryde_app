import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/buttons/StrydeButton.dart';
import 'package:workout_buddy/components/formHelpers/LabelTextElement.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:workout_buddy/components/nav/MyAppBar.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/models/Superset.dart';
import 'package:workout_buddy/utilities/NavigatorHelpers.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';
import 'AllExerciseListScreen.dart';
import 'EditSupersetScreen.dart';


class CreateViewSupersetScreen extends StatefulWidget
{
  Superset superset;

  CreateViewSupersetScreen();
  CreateViewSupersetScreen.superset(this.superset);



  @override
  State<StatefulWidget> createState()
  {
    if (this.superset != null)
    {
      return CreateViewSupersetState.superset(this.superset);
    }

    else
    {
      return CreateViewSupersetState();
    }
  }
}



class CreateViewSupersetState extends State<CreateViewSupersetScreen>
{
  Superset superset;
  LabeledTextInputElement _titleInput;
  bool hasError;


  CreateViewSupersetState()
  {
    superset = Superset.getDemoSuperset(() {}, () {});
    _titleInput = LabeledTextInputElement("Title", "Enter title");
    hasError = false;
  }

  CreateViewSupersetState.superset(Superset superset)
  {
    this.superset = superset;
    _titleInput = LabeledTextInputElement("Title", "Enter title");
    hasError = false;
  }

  @override
  initState()
  {
    hasError = false;

    if (superset != null)
    {
      _titleInput.inputElement.textEditingController.text = superset.name;
    }
  }



  List<Widget> getChildren()
  {
    superset.isReorderable = false;

    if (!hasError)
    {
      return [
        getPadding(10),

        this._titleInput,
        getPadding(15),

        // Exercise & Superset widget
        this._getListViewHeader(),
        superset.getAsListView(),
        getDefaultPadding(),
      ];
    }

    else
    {
      return [
        getPadding(10),

        this._titleInput,
        getPadding(30),

        // Exercise & Superset widget
        LabelTextElement("Exercises"),
        superset.getAsListView(),
        getDefaultPadding(),
      ];
    }
  }

  Row _getListViewHeader()
  {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: LabelTextElement("Exercises"),
              )
            ],
          )
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 2,
                      child: StrydeButton(
                        displayText: "Add", textSize: 14, onTap: ()
                        {
                          navigateToScreen(context, () => AllExerciseListScreen());
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: StrydeButton(
                        displayText: "Edit", textSize: 14, onTap: ()
                        {
                          superset.isReorderable = true;
                          navigateToScreen(context, () => EditSupersetScreen(superset));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: MyAppBar.getAppBar("View Superset"),
      body: SinglePageScrollingWidget(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: getChildren(),
        )
      )
    );
  }
}