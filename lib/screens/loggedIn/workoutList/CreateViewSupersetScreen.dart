import 'package:Stryde/components/formHelpers/elements/basic/LabelText.dart';
import 'package:Stryde/components/formHelpers/elements/text/LabeledTextInputElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:Stryde/models/Superset.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'package:Stryde/utilities/UiHelpers.dart';
import 'AllExerciseListScreen.dart';
import 'EditSupersetScreen.dart';


class CreateViewSupersetScreen extends StatefulWidget
{
  late Superset superset;

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
  late Superset superset;
  late final LabeledTextInputElement _titleInput;
  late bool hasError;


  CreateViewSupersetState() :
    this.superset(Superset.getDemoSuperset(() {}, () {}));

  CreateViewSupersetState.superset(Superset superset)
  {
    this.superset = superset;
    _titleInput = LabeledTextInputElement(
      labelText: "Title",
      placeholderText: "Enter title",
    );
    hasError = false;
  }

  @override
  initState()
  {
    hasError = false;

    if (superset != null)
    {
      _titleInput.inputText = superset.name;
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
        LabelText("Exercises"),
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
                child: LabelText("Exercises"),
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
                          NavigateTo.screen(context, () => AllExerciseListScreen());
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
                          NavigateTo.screen(context, () => EditSupersetScreen(superset));
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
      appBar: StrydeAppBar(titleStr: "View Superset"),
      body: SinglePageScrollingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: getChildren(),
        )
      )
    );
  }
}