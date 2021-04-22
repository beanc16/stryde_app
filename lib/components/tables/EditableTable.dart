import 'package:editable/editable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/tables/EditableTableController.dart';


typedef List<dynamic>? DynamicListCallback();


class EditableTable extends StatefulWidget
{
  late List _columns;
  late List _rows;
  late EditableTableController _controller;
  late Function(dynamic, int)? _onAddRow;
  late Function? _onDeleteRow;
  late final Color _borderColor;
  late final Color _stripeColor1;
  late final Color _stripeColor2;
  late final EdgeInsets _thPadding;
  late final EdgeInsets _tdPadding;
  late final double _trHeight;
  late final TextAlign _tdTextAlign;
  late final TextAlign _thTextAlign;
  late final TextStyle _tdTextStyle;
  late final TextStyle _thTextStyle;
  late Function(dynamic)? _onRowSaved;
  late Function(String)? _onSubmitted;
  late Function()? _onEditingComplete;
  late double _columnRatio;

  EditableTable({
    required List columns,
    List rows = const [],
    required EditableTableController controller,
    Function(dynamic, int)? onAddRow,
    Function? onDeleteRow,
    Color borderColor = Colors.blueGrey,
    Color stripeColor1 = Colors.grey,
    Color stripeColor2 = Colors.white30,
    EdgeInsets thPadding = const EdgeInsets.only(
      top: 10, bottom: 3,
    ),
    EdgeInsets tdPadding = const EdgeInsets.only(
      left: 10, right: 8, top: 12,
    ),
    double trHeight = 48,
    TextAlign tdTextAlign = TextAlign.center,
    TextAlign thTextAlign = TextAlign.center,
    TextStyle tdTextStyle = const TextStyle(
      fontWeight: FontWeight.normal,
    ),
    TextStyle thTextStyle = const TextStyle(
      color: StrydeColors.darkGray,
      fontWeight: FontWeight.bold,
    ),
    Function(dynamic)? onRowSaved,
    Function(String)? onSubmitted,
    Function()? onEditingComplete,
    double columnRatio = 0.2
  })
  {
    this._columns = columns;
    this._rows = rows;
    this._controller = controller;
    this._onAddRow = onAddRow;
    this._onDeleteRow = onDeleteRow;
    this._borderColor = borderColor;
    this._stripeColor1 = stripeColor1;
    this._stripeColor2 = stripeColor2;
    this._thPadding = thPadding;
    this._tdPadding = tdPadding;
    this._trHeight = trHeight;
    this._tdTextAlign = tdTextAlign;
    this._thTextAlign = thTextAlign;
    this._tdTextStyle = tdTextStyle;
    this._thTextStyle = thTextStyle;
    this._onRowSaved = onRowSaved;
    this._onSubmitted = onSubmitted;
    this._onEditingComplete = onEditingComplete;
    this._columnRatio = columnRatio;
  }



  @override
  State<StatefulWidget> createState()
  {
    return EditableTableState(this._columns, this._rows,
                              this._controller, this._onAddRow,
                              this._onDeleteRow, this._borderColor,
                              this._stripeColor1, this._stripeColor2,
                              this._thPadding, this._tdPadding,
                              this._trHeight, this._tdTextAlign,
                              this._thTextAlign, this._tdTextStyle,
                              this._thTextStyle, this._onRowSaved,
                              this._onSubmitted, this._columnRatio,
                              this._onEditingComplete);
  }
}



class EditableTableState extends State<EditableTable>
{
  late final GlobalKey<EditableState> _tableKey;
  EditableTableController _controller;
  List _columns;
  List _rows;
  Function(dynamic, int)? _onAddRow;
  Function? _onDeleteRow;
  Color _borderColor;
  Color _stripeColor1;
  Color _stripeColor2;
  final EdgeInsets _thPadding;
  final EdgeInsets _tdPadding;
  final double _trHeight;
  final TextAlign _tdTextAlign;
  final TextAlign _thTextAlign;
  final TextStyle _tdTextStyle;
  final TextStyle _thTextStyle;
  final Function(dynamic)? _onRowSaved;
  final Function(String)? _onSubmitted;
  late Function()? _onChanged;
  final double _columnRatio;

  EditableTableState(this._columns, this._rows, this._controller,
                     this._onAddRow, this._onDeleteRow,
                     this._borderColor, this._stripeColor1,
                     this._stripeColor2, this._thPadding,
                     this._tdPadding, this._trHeight,
                     this._tdTextAlign, this._thTextAlign,
                     this._tdTextStyle, this._thTextStyle,
                     this._onRowSaved, this._onSubmitted,
                     this._columnRatio, this._onChanged)
  {
    this._tableKey = GlobalKey<EditableState>();
    _initializeListeners();
    _controller.getEditedRows = _getEditedRowsForParent();
    //_controller.setIsTableBuilt(true);
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



  DynamicListCallback _getEditedRowsForParent()
  {
    return ()
    {
      return this._getEditedRows();
    };
  }

  void _addNewRow()
  {
    setState(()
    {
      _tableKey.currentState?.createRow();
    });

    if (_onAddRow != null)
    {
      int? numOfRows = _tableKey.currentState?.rowCount;

      if (numOfRows != null)
      {
        dynamic addedRow = _tableKey.currentState?.rows![numOfRows];
        _onAddRow!(addedRow, numOfRows);
      }
    }
  }

  void _deleteLastRow()
  {
    setState(()
    {
      _tableKey.currentState?.deleteLastRow(_rows);
    });

    if (_onDeleteRow != null)
    {
      _onDeleteRow!();
    }
  }

  void _deleteRow(int index)
  {
    setState(()
    {
      _tableKey.currentState?.deleteRow(_rows, index);
    });
  }

  List<dynamic> _getEditedRows()
  {
    return _tableKey.currentState?.editedRows ?? [];
  }



  @override
  Widget build(BuildContext context)
  {
    return Editable(
      // Data
      key: _tableKey,
      columns: _columns,
      rows: _rows,

      // Border
      borderColor: _borderColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),

      // Row colors
      zebraStripe: true,
      stripeColor1: _stripeColor1,
      stripeColor2: _stripeColor2,

      // Callbacks
      onRowSaved: _onRowSaved,
      onSubmitted: _onSubmitted,
      //onChanged: _onChanged,

      // TODO: Make save icon for each row actually be a delete icon

      // Headers
      thAlignment: _thTextAlign,
      thVertAlignment: CrossAxisAlignment.end,
      thStyle: _thTextStyle,
      thPaddingTop: _thPadding.top,
      thPaddingBottom: _thPadding.bottom,
      thPaddingLeft: _thPadding.left,
      thPaddingRight: _thPadding.right,

      // Normal cells
      tdStyle: _tdTextStyle,
      tdAlignment: _tdTextAlign,
      tdEditableMaxLines: 100,
      tdPaddingTop: _tdPadding.top,
      tdPaddingBottom: _tdPadding.bottom,
      tdPaddingLeft: _tdPadding.left,
      tdPaddingRight: _tdPadding.right,

      // Rows
      trHeight: _trHeight,
      columnRatio: _columnRatio,
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
