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



  void setIsLoading(bool isLoading)
  {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setHideAllChildren(bool shouldHideAllChildren)
  {
    _hideAllChildren = shouldHideAllChildren;
    notifyListeners();
  }
}