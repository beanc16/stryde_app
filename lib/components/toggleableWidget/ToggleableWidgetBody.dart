import 'package:flutter/cupertino.dart';

import 'EmptyWidget.dart';

class ToggleableWidgetBody extends StatelessWidget
{
  late Widget _child;
  late Widget _loadingIndicator;
  late bool _isLoading;
  late bool _showLoadingIndicatorOnLoading;
  late bool _hideAllChildren;

  ToggleableWidgetBody({
    required Widget child,
    required Widget loadingIndicator,
    required bool isLoading,
    required bool showLoadingIndicatorOnLoading,
    required bool hideAllChildren,
  })
  {
    this._child = child;
    this._loadingIndicator = loadingIndicator;
    this._hideAllChildren = hideAllChildren;
    this._isLoading = isLoading;
    this._showLoadingIndicatorOnLoading = showLoadingIndicatorOnLoading;
  }



  @override
  Widget build(BuildContext context)
  {
    if (_hideAllChildren)
    {
      // Display a widget that takes up no space
      return EmptyWidget();
    }

    else if (_isLoading && !_hideAllChildren)
    {
      if (_showLoadingIndicatorOnLoading)
      {
        return _loadingIndicator;
      }

      else
      {
        // Display a widget that takes up no space
        return EmptyWidget();
      }
    }

    // (!_isLoading && !_hideAllChildren)
    else
    {
      return _child;
    }
  }
}