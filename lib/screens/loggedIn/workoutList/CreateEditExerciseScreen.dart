import 'dart:convert';
import 'package:Stryde/components/formHelpers/elements/text/LabeledTextInputElement.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooLongException.dart';
import 'package:Stryde/components/formHelpers/exceptions/InputTooShortException.dart';
import 'package:Stryde/components/formHelpers/multiSelectFlutterHelpers/MultiSelectBottomSheetChipDisplay.dart';
import 'package:Stryde/components/formHelpers/multiSelectFlutterHelpers/SingleSelectBottomSheetChipDisplay.dart';
import 'package:Stryde/components/strydeHelpers/widgets/buttons/StrydeButton.dart';
import 'package:Stryde/components/strydeHelpers/widgets/toggleableWidgets/StrydeErrorToggleableWidget.dart';
import 'package:Stryde/components/strydeHelpers/widgets/toggleableWidgets/StrydeSuccessToggleableWidget.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidgetMap.dart';
import 'package:Stryde/models/enums/ExerciseMovementTypeEnum.dart';
import 'package:Stryde/models/enums/ExerciseMuscleTypeEnum.dart';
import 'package:Stryde/models/enums/ExerciseWeightTypeEnum.dart';
import 'package:Stryde/models/enums/MuscleGroupEnum.dart';
import 'package:Stryde/utilities/HttpQueryHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeConstants.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:Stryde/models/ExerciseMovementType.dart';
import 'package:Stryde/models/ExerciseMuscleType.dart';
import 'package:Stryde/models/ExerciseWeightType.dart';
import 'package:Stryde/models/MuscleGroup.dart';
import 'package:Stryde/utilities/UiHelpers.dart';


class CreateEditExerciseScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return CreateEditExerciseScreenState();
  }
}



class CreateEditExerciseScreenState extends State<CreateEditExerciseScreen>
{
  late final LabeledTextInputElement _nameInput;
  late final LabeledTextInputElement _descriptionInput;
  late MultiSelectBottomSheetChipDisplay _muscleGroupDropdown;
  late SingleSelectBottomSheetChipDisplay _weightTypeDropdown;
  late SingleSelectBottomSheetChipDisplay _muscleTypeDropdown;
  late SingleSelectBottomSheetChipDisplay _movementTypeDropdown;
  late int exerciseWeightTypeId;
  late int exerciseMuscleTypeId;
  late int exerciseMovementTypeId;
  late List<int> muscleGroupIds;
  late ToggleableWidgetMap<String> _toggleableWidgets;

  CreateEditExerciseScreenState()
  {
    exerciseWeightTypeId = -1;
    exerciseMuscleTypeId = -1;
    exerciseMovementTypeId = -1;
    muscleGroupIds = [];

    // Name & Description
    _nameInput = LabeledTextInputElement(
      labelText: "Exercise",
      placeholderText: "Enter exercise",
      minInputLength: 1,
      maxInputLength: 45,
    );
    _descriptionInput = LabeledTextInputElement.textArea(
      labelText: "Description",
      placeholderText: "Enter description",
      maxInputLength: 1000,
    );

    // Muscle Groups
    List<MultiSelectItem> muscleGroupList = StrydeConstants.muscleGroupList
      .map((element) =>
        MultiSelectItem<MuscleGroup>(element, element.value.toStringShort()))
      .toList();
    _muscleGroupDropdown = MultiSelectBottomSheetChipDisplay(
      muscleGroupList, buttonText: "Muscle Groups Used",
      selectionTitleText: "Select Muscle Groups",
      selectedColor: StrydeColors.darkBlue,
      selectedTextColor: Colors.white, isSearchable: true,
      chipColor: StrydeColors.darkBlue, chipTextColor: Colors.white,
      onSelectionChanged: (values) => _onExerciseMuscleGroupsSelectionChanged(values),
    );

    // Weight Type
    List<MultiSelectItem> weightTypeList = StrydeConstants.weightTypeList
      .map((element) =>
        MultiSelectItem<ExerciseWeightType>(element, element.value.toStringShort()))
      .toList();
    _weightTypeDropdown = SingleSelectBottomSheetChipDisplay(
      weightTypeList, buttonText: "Weight Type",
      selectionTitleText: "Select Weight Type",
      selectedColor: StrydeColors.darkBlue,
      selectedTextColor: Colors.white, isSearchable: false,
      chipColor: StrydeColors.darkBlue, chipTextColor: Colors.white,
      onSelectionChanged: (values) => _onExerciseWeightTypeSelectionChanged(values),
    );

    // Muscle Type
    List<MultiSelectItem> muscleTypeList = StrydeConstants.muscleTypeList
      .map((element) =>
        MultiSelectItem<ExerciseMuscleType>(element, element.value.toStringShort()))
      .toList();
    _muscleTypeDropdown = SingleSelectBottomSheetChipDisplay(
      muscleTypeList, buttonText: "Muscle Type",
      selectionTitleText: "Select Muscle Type",
      selectedColor: StrydeColors.darkBlue,
      selectedTextColor: Colors.white, isSearchable: false,
      chipColor: StrydeColors.darkBlue, chipTextColor: Colors.white,
      onSelectionChanged: (values) => _onExerciseMuscleTypeSelectionChanged(values),
    );

    // Movement Type
    List<MultiSelectItem> movementTypeList = StrydeConstants.movementTypeList
      .map((element) =>
        MultiSelectItem<ExerciseMovementType>(element, element.value.toStringShort()))
      .toList();
    _movementTypeDropdown = SingleSelectBottomSheetChipDisplay(
      movementTypeList, buttonText: "Movement Type",
      selectionTitleText: "Select Movement Type",
      selectedColor: StrydeColors.darkBlue,
      selectedTextColor: Colors.white, isSearchable: true,
      chipColor: StrydeColors.darkBlue, chipTextColor: Colors.white,
      onSelectionChanged: (values) => _onExerciseMovementTypeSelectionChanged(values),
    );

    _toggleableWidgets = ToggleableWidgetMap({
       "successMsg": StrydeSuccessToggleableWidget(
         showLoadingIndicatorOnLoading: true,
         successMsg: "Exercise Successfully Saved",
       ),
       "queryError": StrydeErrorToggleableWidget(
         errorMsg: "Exercise failed to save",
       ),
       "notEnoughInputError": StrydeErrorToggleableWidget(
         errorMsg: "Must fill out all input fields",
       ),
       "inputTooShortError": StrydeErrorToggleableWidget(
         errorMsg: "Exercise name is too short",
       ),
       "inputTooLongError": StrydeErrorToggleableWidget(
         errorMsg: "Exercise name is too long",
       ),
     });
  }



  List<Widget> _getChildren()
  {
    return [
      getDefaultPadding(),

      _nameInput,
      getDefaultPadding(),

      //_descriptionInput,
      //getDefaultPadding(),

      _muscleGroupDropdown,
      getDefaultPadding(),

      _weightTypeDropdown,
      getDefaultPadding(),

      _muscleTypeDropdown,
      getDefaultPadding(),

      _movementTypeDropdown,
      getDefaultPadding(),

      _toggleableWidgets,

      StrydeButton(
        displayText: "Save",
        textSize: 20,
        onTap: () => _onSave(),
      ),
      getDefaultPadding(),
    ];
  }



  void _onSave() async
  {
    if (_isInputValid())
    {
      Map<String, String> postData = {
        "exerciseName": _nameInput.inputText,
        "exerciseDescription": _descriptionInput.inputText,
        "exerciseWeightTypeId": exerciseWeightTypeId.toString(),
        "exerciseMuscleTypeId": exerciseMuscleTypeId.toString(),
        "exerciseMovementTypeId": exerciseMovementTypeId.toString(),
        "muscleGroupIds": jsonEncode(muscleGroupIds),
      };
      print("postData: " + postData.toString());


      await HttpQueryHelper.post(
        "/user/create/exercise",
        postData,
        onBeforeQuery: () => _onBeforeQuery(),
        onSuccess: (dynamic response) => _onSaveGoalSuccess(response),
        onFailure: (dynamic response) => _onSaveGoalFail(response)
      );
    }
    else
    {
      _tryThrowExceptions();
    }
  }

  void _onBeforeQuery()
  {

    _toggleableWidgets.hideAllExcept("successMsg");
    _toggleableWidgets.showLoadingIcon("successMsg");
  }

  void _onSaveGoalSuccess(dynamic response) async
  {
    // Display success message
    _toggleableWidgets.showChildFor(
      "successMsg", const Duration(seconds: 3)
    );

    print("success: " + response.toString());

    // Update local storage of exercises
    /*
    Exercise exercise = Exercise.model(
      id,
      _nameInput.inputText,
      _descriptionInput.inputText,
      exerciseWeightType,
      exerciseMuscleType,
      exerciseMovementType,
      muscleGroups
    );
    StrydeUserStorage.allExercises?.add(exercise);
    */
  }

  void _onSaveGoalFail(dynamic response)
  {
    print("Fail: " + response.toString());
    _toggleableWidgets.hideChildAndLoadingIcon("successMsg");
    _toggleableWidgets.showChild("queryErrorMsg");
  }

  bool _isInputValid()
  {
    return (_nameInput.inputText.length > 0 &&
            //_descriptionInput.inputText.length > 0 &&
            exerciseWeightTypeId != -1 &&
            exerciseMuscleTypeId != -1 &&
            exerciseMovementTypeId != -1 &&
            muscleGroupIds.length > 0);
  }

  void _tryThrowExceptions()
  {
    try
    {
      if (!_isInputValid())
      {
        _toggleableWidgets.hideAllExcept("inputTooLongError");
        _toggleableWidgets.showChildFor(
          "notEnoughInputError", Duration(seconds: 3,)
        );
        return;
      }

      _nameInput.tryThrowExceptionMessage();
      //_descriptionInput.tryThrowExceptionMessage();
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



  void _onExerciseWeightTypeSelectionChanged(List<dynamic> values)
  {
    if (values.length > 0)
    {
      dynamic value = values[0];

      if (value is ExerciseWeightType)
      {
        exerciseWeightTypeId = (value.id)!;
      }
    }
    else
    {
      exerciseWeightTypeId = -1;
    }
  }

  void _onExerciseMuscleTypeSelectionChanged(List<dynamic> values)
  {
    if (values.length > 0)
    {
      dynamic value = values[0];

      if (value is ExerciseMuscleType)
      {
        exerciseMuscleTypeId = (value.id)!;
      }
    }
    else
    {
      exerciseMuscleTypeId = -1;
    }
  }

  void _onExerciseMovementTypeSelectionChanged(List<dynamic> values)
  {
    if (values.length > 0)
    {
      dynamic value = values[0];

      if (value is ExerciseMovementType)
      {
        exerciseMovementTypeId = (value.id)!;
      }
    }
    else
    {
      exerciseMovementTypeId = -1;
    }
  }

  void _onExerciseMuscleGroupsSelectionChanged(List<dynamic> values)
  {
    muscleGroupIds = [];

    if (values.length > 0)
    {
      for (int i = 0; i < values.length; i++)
      {
        dynamic value = values[i];

        if (value is MuscleGroup)
        {
          muscleGroupIds.add((value.id)!);
        }
      }
    }
  }



  @override
  Widget build(BuildContext context)
  {
    SinglePageScrollingWidget child = SinglePageScrollingWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _getChildren(),
      ),
    );

    return Scaffold(
      appBar: StrydeAppBar(titleStr: "Stryde"),
      body: Container(
        margin: getDefaultMargin(),
        child: child,
      ),
    );
  }
}