import 'package:flutter/cupertino.dart';
import 'package:Stryde/components/tables/EditableTable.dart';

class EditableTableController extends ChangeNotifier
{
  late EditableTableState state;
  late bool shouldAddNewRow = false;
  late bool shouldDeleteLastRow = false;

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