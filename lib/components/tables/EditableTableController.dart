import 'package:flutter/cupertino.dart';
import 'package:workout_buddy/components/tables/EditableTable.dart';

class EditableTableController extends ChangeNotifier
{
  EditableTableState state;
  bool shouldAddNewRow = false;
  bool shouldDeleteLastRow = false;

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