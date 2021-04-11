import 'package:flutter/cupertino.dart';


typedef List<dynamic>? DynamicListCallback();


class EditableTableController extends ChangeNotifier
{
  bool shouldAddNewRow = false;
  bool shouldDeleteLastRow = false;
  DynamicListCallback? getEditedRows;
  bool tableIsBuilt = false;
  late ValueChanged<bool> onTableBuilt;
  late Function() onChanged;
  late Function() saveExerciseInfo;

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

  void setIsTableBuilt(bool tableIsBuilt)
  {
    tableIsBuilt = tableIsBuilt;
    onTableBuilt(tableIsBuilt);
  }

  void editingIsComplete()
  {
    onChanged();
  }
}