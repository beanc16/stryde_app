import 'package:flutter/cupertino.dart';


typedef List<dynamic>? DynamicListCallback();


class EditableTableController extends ChangeNotifier
{
  late bool shouldAddNewRow = false;
  late bool shouldDeleteLastRow = false;
  DynamicListCallback? getEditedRows;

  EditableTableController();



  void addNewRow()
  {
    shouldAddNewRow = true;
    notifyListeners();
  }

  void deleteLastRow()
  {
    shouldDeleteLastRow = true;
    notifyListeners();
  }
}