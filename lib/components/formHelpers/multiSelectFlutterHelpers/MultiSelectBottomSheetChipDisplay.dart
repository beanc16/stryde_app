import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';


class MultiSelectBottomSheetChipDisplay extends StatefulWidget
{
  List<MultiSelectItem> _allSelectionItems;
  List<MultiSelectItem<dynamic>> _chipDisplayItems;
  Color _chipColor;
  Color _chipTextColor;
  Color _selectedColor;
  Color _selectedTextColor;
  String _buttonText;
  String _selectionTitleText;
  bool _isSearchable;

  MultiSelectBottomSheetChipDisplay(this._allSelectionItems, {
    List<MultiSelectItem<dynamic>> chipDisplayItems,
    Color chipColor,
    Color chipTextColor,
    Color selectedColor,
    Color selectedTextColor,
    String buttonText = "",
    String selectionTitleText = "",
    bool isSearchable = true,
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
  }


  @override
  State<StatefulWidget> createState()
  {
    return MultiSelectBottomSheetChipDisplayState(
      this._allSelectionItems, this._chipDisplayItems,
      this. _chipColor, this._chipTextColor, this._selectedColor,
      this._selectedTextColor, this._buttonText,
      this._selectionTitleText, this._isSearchable
    );
  }
}



class MultiSelectBottomSheetChipDisplayState extends
    State<MultiSelectBottomSheetChipDisplay>
{
  List<MultiSelectItem> _allSelectionItems;
  MultiSelectChipDisplay selectedChipsDisplayList;
  Text _buttonText;
  Text _selectionTitleText;
  Color _selectedColor;
  Color _selectedTextColor;
  bool _isSearchable;

  MultiSelectBottomSheetChipDisplayState(this._allSelectionItems,
    List<MultiSelectItem<dynamic>> chipDisplayItems,
    Color chipColor,
    Color chipTextColor,
    this._selectedColor,
    this._selectedTextColor,
    String buttonText,
    String selectionTitleText,
    this._isSearchable
  )
  {
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



  @override
  Widget build(BuildContext context)
  {
    return MultiSelectBottomSheetField(
      //initialValue: _initialMuscleGroups,
      items: _allSelectionItems,
      selectedColor: _selectedColor,
      selectedItemsTextStyle: TextStyle(
        color: _selectedTextColor
      ),

      onConfirm: (values)
      {
        // When tags are confirmed
      },

      chipDisplay: selectedChipsDisplayList,

      initialChildSize: 0.4,
      listType: MultiSelectListType.CHIP,
      searchable: _isSearchable,

      buttonText: _buttonText,
      title: _selectionTitleText,
    );
  }
}