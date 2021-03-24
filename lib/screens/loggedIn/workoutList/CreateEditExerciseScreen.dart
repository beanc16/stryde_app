import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:workout_buddy/components/formHelpers/TextElements.dart';
import 'package:workout_buddy/components/formHelpers/multiSelectFlutterHelpers/MultiSelectBottomSheetChipDisplay.dart';
import 'package:workout_buddy/components/formHelpers/multiSelectFlutterHelpers/SingleSelectBottomSheetChipDisplay.dart';
import 'package:workout_buddy/components/misc/StrydeColors.dart';
import 'package:workout_buddy/components/nav/MyAppBar.dart';
import 'package:workout_buddy/components/strydeHelpers/StrydeConstants.dart';
import 'package:workout_buddy/components/uiHelpers/SinglePageScrollingWidget.dart';
import 'package:workout_buddy/models/ExerciseMovementType.dart';
import 'package:workout_buddy/models/ExerciseMuscleType.dart';
import 'package:workout_buddy/models/ExerciseWeightType.dart';
import 'package:workout_buddy/models/MuscleGroup.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';


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
  LabeledTextInputElement _nameInput;
  LabeledTextInputElement _descriptionInput;
  MultiSelectBottomSheetChipDisplay _muscleGroupDropdown;
  SingleSelectBottomSheetChipDisplay _weightTypeDropdown;
  SingleSelectBottomSheetChipDisplay _muscleTypeDropdown;
  SingleSelectBottomSheetChipDisplay _movementTypeDropdown;

  CreateEditExerciseScreenState()
  {
    // Name & Description
    _nameInput = LabeledTextInputElement("Exercise", "Enter exercise");
    _descriptionInput = LabeledTextInputElement.textArea(
      "Description",
      "Enter description"
    );

    // Muscle Groups
    List<MultiSelectItem> muscleGroupList = StrydeConstants.muscleGroupList
      .map((element) =>
        MultiSelectItem<MuscleGroup>(element, element.name))
      .toList();
    _muscleGroupDropdown = MultiSelectBottomSheetChipDisplay(
      muscleGroupList, buttonText: "Muscle Groups Used",
      selectionTitleText: "Select Muscle Groups",
      selectedColor: StrydeColors.darkBlue,
      selectedTextColor: Colors.white, isSearchable: true,
      chipColor: StrydeColors.darkBlue, chipTextColor: Colors.white,
    );

    // Weight Type
    List<MultiSelectItem> weightTypeList = StrydeConstants.weightTypeList
      .map((element) =>
        MultiSelectItem<ExerciseWeightType>(element, element.name))
      .toList();
    _weightTypeDropdown = SingleSelectBottomSheetChipDisplay(
      weightTypeList, buttonText: "Weight Type",
      selectionTitleText: "Select Weight Type",
      selectedColor: StrydeColors.darkBlue,
      selectedTextColor: Colors.white, isSearchable: false,
      chipColor: StrydeColors.darkBlue, chipTextColor: Colors.white,
    );

    // Muscle Type
    List<MultiSelectItem> muscleTypeList = StrydeConstants.muscleTypeList
      .map((element) =>
        MultiSelectItem<ExerciseMuscleType>(element, element.name))
      .toList();
    _muscleTypeDropdown = SingleSelectBottomSheetChipDisplay(
      muscleTypeList, buttonText: "Muscle Type",
      selectionTitleText: "Select Muscle Type",
      selectedColor: StrydeColors.darkBlue,
      selectedTextColor: Colors.white, isSearchable: false,
      chipColor: StrydeColors.darkBlue, chipTextColor: Colors.white,
    );

    // Muscle Type
    List<MultiSelectItem> movementTypeList = StrydeConstants.movementTypeList
      .map((element) =>
        MultiSelectItem<ExerciseMovementType>(element, element.name))
      .toList();
    _movementTypeDropdown = SingleSelectBottomSheetChipDisplay(
      movementTypeList, buttonText: "Movement Type",
      selectionTitleText: "Select Movement Type",
      selectedColor: StrydeColors.darkBlue,
      selectedTextColor: Colors.white, isSearchable: true,
      chipColor: StrydeColors.darkBlue, chipTextColor: Colors.white,
    );
  }



  List<Widget> _getChildren()
  {
    return [
      getDefaultPadding(),

      _nameInput,
      getDefaultPadding(),

      _descriptionInput,
      getDefaultPadding(),

      _muscleGroupDropdown,
      getDefaultPadding(),

      _weightTypeDropdown,
      getDefaultPadding(),

      _muscleTypeDropdown,
      getDefaultPadding(),

      _movementTypeDropdown,
      getDefaultPadding(),
    ];
  }



  @override
  Widget build(BuildContext context)
  {
    SinglePageScrollingWidget child = SinglePageScrollingWidget(
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _getChildren(),
      ),
    );

    return Scaffold(
      appBar: MyAppBar.getAppBar("Stryde"),
      body: Container(
        margin: getDefaultMargin(),
        child: child,
      ),
    );
  }
}