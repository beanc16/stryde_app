import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';


class SingleSelectBottomSheetChipDisplay extends StatefulWidget
{
  late List<MultiSelectItem> _allSelectionItems;
  late List<MultiSelectItem<dynamic>>? _chipDisplayItems;
  late Color? _chipColor;
  late Color? _chipTextColor;
  late Color? _selectedColor;
  late Color? _selectedTextColor;
  late String _buttonText;
  late String _selectionTitleText;
  late bool _isSearchable;
  late Function(List<dynamic>)? _onSelectionChanged;

  SingleSelectBottomSheetChipDisplay(this._allSelectionItems, {
    List<MultiSelectItem<dynamic>>? chipDisplayItems,
    Color? chipColor,
    Color? chipTextColor,
    Color? selectedColor,
    Color? selectedTextColor,
    String buttonText = "",
    String selectionTitleText = "",
    bool isSearchable = true,
    Function(List<dynamic>)? onSelectionChanged
  })
  {
    _chipDisplayItems = chipDisplayItems;
    _chipColor = chipColor;
    _chipTextColor = chipTextColor;
    _selectedColor = selectedColor;
    _selectedTextColor = selectedTextColor;
    _buttonText = buttonText;
    _selectionTitleText = selectionTitleText;
    _isSearchable = isSearchable;
    _onSelectionChanged = onSelectionChanged;
  }


  @override
  State<StatefulWidget> createState()
  {
    return SingleSelectBottomSheetChipDisplayState(
      this._allSelectionItems, this._chipDisplayItems,
      this. _chipColor, this._chipTextColor, this._selectedColor,
      this._selectedTextColor, this._buttonText,
      this._selectionTitleText, this._isSearchable,
      this._onSelectionChanged
    );
  }
}



class SingleSelectBottomSheetChipDisplayState extends
    State<SingleSelectBottomSheetChipDisplay>
{
  List<MultiSelectItem> _allSelectionItems;
  late MultiSelectChipDisplay selectedChipsDisplayList;
  late Text _buttonText;
  late Text _selectionTitleText;
  Color? _selectedColor;
  Color? _selectedTextColor;
  bool _isSearchable;
  late List<dynamic> _prevSelectedValues;
  late Function(List<dynamic>) _onSelectionChanged;


  SingleSelectBottomSheetChipDisplayState(this._allSelectionItems,
    List<MultiSelectItem<dynamic>>? chipDisplayItems,
    Color? chipColor,
    Color? chipTextColor,
    this._selectedColor,
    this._selectedTextColor,
    String buttonText,
    String selectionTitleText,
    this._isSearchable,
    Function(List<dynamic>)? onSelectionChanged,
  )
  {
    if (onSelectionChanged == null)
    {
      this._onSelectionChanged = _onSelectionChangedDefault;
    }
    else
    {
      this._onSelectionChanged = onSelectionChanged;
    }

    _buttonText = Text(
      buttonText,
      style: TextStyle(
        fontSize: 16
      ),
    );

    _selectionTitleText = Text(
      selectionTitleText,
      style: TextStyle(
        fontSize: 16
      ),
    );

    selectedChipsDisplayList = MultiSelectChipDisplay(
      items: chipDisplayItems,
      onTap: (tappedChip)
      {
        setState(()
        {
          // Click chip (tag) after its selected
          // TODO: Try to delete chip once its tapped
        });
      },
      chipColor: chipColor,
      textStyle: TextStyle(
        color: chipTextColor
      ),
    );
  }

  void _onSelectionChangedSingleValue(List<dynamic> selectedValues)
  {
    // Too many values selected
    if (selectedValues.length > 1)
    {
      List<dynamic> valuesToRemove = [];

      for (dynamic value in selectedValues)
      {
        // Value was previously selected
        if (identical(value, _prevSelectedValues[0]))
        {
          valuesToRemove.add(value);
        }
      }

      // Remove each value
      for (dynamic value in valuesToRemove)
      {
        selectedValues.remove(value);
      }
    }

    // Just enough or no values selected; Set after removing old values
    _prevSelectedValues = selectedValues;

    // Run callback
    _onSelectionChanged(selectedValues);
  }

  void _onSelectionChangedDefault(List<dynamic> selectedValues)
  {
  }



  @override
  Widget build(BuildContext context)
  {
    return MultiSelectBottomSheetField(
      //initialValue: _initialMuscleGroups,
      onConfirm: (List<dynamic> confirmed) => (){print(confirmed);},
      items: _allSelectionItems,
      selectedColor: _selectedColor,
      selectedItemsTextStyle: TextStyle(
        color: _selectedTextColor
      ),

      onSelectionChanged: (List<dynamic> selectedValues) =>
          _onSelectionChangedSingleValue(selectedValues),

      chipDisplay: selectedChipsDisplayList,

      initialChildSize: 0.4,
      listType: MultiSelectListType.CHIP,
      searchable: _isSearchable,

      buttonText: _buttonText,
      title: _selectionTitleText,
    );
  }
}