import 'package:editable/editable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:workout_buddy/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:workout_buddy/components/tables/EditableTableController.dart';


class EditableTable extends StatefulWidget
{
  List _columns;
  List _rows;
  EditableTableController _controller;
  Function _onAddRow;
  Function _onDeleteRow;

  EditableTable({
    @required List columns,
    List rows = const [],
    @required EditableTableController controller,
    Function onAddRow,
    Function onDeleteRow,
  })
  {
    this._columns = columns;
    this._rows = rows;
    this._controller = controller;
    this._onAddRow = onAddRow;
    this._onDeleteRow = onDeleteRow;
  }



  @override
  State<StatefulWidget> createState()
  {
    return EditableTableState(this._columns, this._rows,
                              this._controller, this._onAddRow,
                              this._onDeleteRow);
  }
}



class EditableTableState extends State<EditableTable>
{
  GlobalKey<EditableState> _tableKey;
  EditableTableController _controller;
  List _columns;
  List _rows;
  Function _onAddRow;
  Function _onDeleteRow;

  EditableTableState(this._columns, this._rows, this._controller,
                     this._onAddRow, this._onDeleteRow)
  {
    this._tableKey = GlobalKey<EditableState>();
    _initializeListeners();
  }

  void _initializeListeners()
  {
    _controller.addListener(()
    {
      if (_controller.shouldAddNewRow)
      {
        _addNewRow();
        _controller.shouldAddNewRow = false;
      }
    });

    _controller.addListener(()
    {
      if (_controller.shouldDeleteLastRow)
      {
        _deleteLastRow();
        _controller.shouldDeleteLastRow = false;
      }
    });
  }



  void _addNewRow()
  {
    setState(()
    {
      _tableKey.currentState.createRow();
    });

    if (_onAddRow != null)
    {
      _onAddRow();
    }
  }

  void _deleteLastRow()
  {
    setState(()
    {
      _tableKey.currentState.deleteLastRow(_rows);
    });

    if (_onDeleteRow != null)
    {
      _onDeleteRow();
    }
  }

  void _deleteRow(int index)
  {
    setState(()
    {
      _tableKey.currentState.deleteRow(_rows, index);
    });
  }

  List<dynamic> _getEditedRows()
  {
    return _tableKey.currentState.editedRows;
  }



  @override
  Widget build(BuildContext context)
  {
    Color lGray = StrydeColors.lightGray;
    Color dGray = StrydeColors.darkGray;

    return Editable(
      // Data
      key: _tableKey,
      columns: _columns,
      rows: _rows,

      // Border
      borderColor: Colors.blueGrey,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),

      // Row colors
      zebraStripe: true,
      stripeColor1: Color.fromRGBO(lGray.red, lGray.green, lGray.blue, 0.175),
      stripeColor2: Color.fromRGBO(dGray.red, dGray.green, dGray.blue, 0.175),

      // Create Button
      showCreateButton: false,
      createButtonAlign: CrossAxisAlignment.start,
      createButtonShape: BoxShape.circle,
      createButtonColor: StrydeColors.purple,
      createButtonIcon: Icon(Icons.add, color: Colors.white),

      // Save Button
      showSaveIcon: true,
      saveIconColor: Colors.black,

      // Callbacks
      onRowSaved: (value)
      {
        // On save button pressed
        print("Row saved: " + value.toString());
      },
      onSubmitted: (value)
      {
        // On edit complete (on mobile) or enter is tapped (on desktop)
        print("\n\n\nSubmitted: " + value.toString());
      },

      // Headers
      thAlignment: TextAlign.center,
      thVertAlignment: CrossAxisAlignment.end,
      thStyle: TextStyle(
        color: StrydeColors.darkGray,
        fontWeight: FontWeight.bold,
      ),
      thPaddingTop: 10,
      thPaddingBottom: 3,

      // Normal cells
      tdStyle: TextStyle(fontWeight: FontWeight.normal),
      tdAlignment: TextAlign.center,
      tdEditableMaxLines: 100,
      tdPaddingTop: 12,
      tdPaddingBottom: 0,
      tdPaddingLeft: 10,
      tdPaddingRight: 8,

      // Rows
      trHeight: 48,
      columnRatio: 0.14,
    );
  }
}





extension EditableStateCustom on EditableState
{
  dynamic deleteRow(List rows, int index)
  {
    if (rows != null && rows.length != 0)
    {
      return rows.removeAt(index);
    }
  }

  dynamic deleteLastRow(List rows)
  {
    if (rows != null && rows.length != 0)
    {
      return rows.removeLast();
    }
  }
}
