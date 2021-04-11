import 'package:flutter/cupertino.dart';


class ToggleableWidgetController extends ChangeNotifier
{
  late bool _isLoading;
  late bool _hideAllChildren;

  get isLoading => _isLoading;
  get hideAllChildren => _hideAllChildren;


  ToggleableWidgetController({
    required bool isLoading,
    required bool hideOnStartup,
  })
  {
    this._isLoading = isLoading;
    this._hideAllChildren = hideOnStartup;
  }



  Future setIsLoading(bool isLoading) async
  {
    _isLoading = isLoading;
    notifyListeners();
    return Future;
  }

  Future setHideAllChildren(bool shouldHideAllChildren) async
  {
    _hideAllChildren = shouldHideAllChildren;
    notifyListeners();
    return Future;
  }
}