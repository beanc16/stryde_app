import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/toggleables/EmptyWidget.dart';


class ToggleableWidget extends StatefulWidget
{
  Widget _child;
  Widget _loadingIndicator;
  bool _isLoading;
  bool _showLoadingIndicatorOnLoading;
  bool _hideAllChildren;
  ToggleableWidgetState _state;


  ToggleableWidget({
    @required Widget child,
    Widget loadingIndicator,
    bool showLoadingIndicatorOnLoading = true,
    bool isLoading = false,
    bool hideOnStartup = false,
  })
  {
    this._child = child;
    this._isLoading = isLoading;
    this._showLoadingIndicatorOnLoading = showLoadingIndicatorOnLoading;
    this._hideAllChildren = hideOnStartup;

    if (loadingIndicator == null)
    {
      this._loadingIndicator = _getDefaultLoadingIndicator();
    }
    else
    {
      this._loadingIndicator = loadingIndicator;
    }
  }

  Widget _getDefaultLoadingIndicator()
  {
    return Center(
      child: CircularProgressIndicator(),
    );
  }



  void _setIsLoading(bool isLoading)
  {
    if (_state != null)
    {
      this._state.setIsLoading(isLoading);
      this._isLoading = isLoading;
    }

    else
    {
      print("\nWARNING: Tried to call _setIsLoading on a " +
            "ToggleableWidget with an uninitialized state\n");
    }
  }

  void _setHideAllChildren(bool shouldHideAllChildren)
  {
    if (_state != null)
    {
      this._state.setHideAllChildren(shouldHideAllChildren);
      this._hideAllChildren = shouldHideAllChildren;
    }

    else
    {
      print("\nWARNING: Tried to call _setHideAllChildren on a " +
                "ToggleableWidget with an uninitialized state\n");
    }
  }

  void showChildAfter(Duration duration) async
  {
    await Future.delayed(duration);
    showChild();
  }

  void showChildFor(Duration duration) async
  {
    showChild();
    await Future.delayed(duration);
    hideChildAndLoadingIcon();
  }

  void showChild()
  {
    this._setIsLoading(false);
    this.showChildOrLoadingIcon();
  }

  void hideChildAfter(Duration duration) async
  {
    await Future.delayed(duration);
    hideChild();
  }

  void hideChild()
  {
    this._setIsLoading(true);
  }

  void showLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    showLoadingIcon();
  }

  void showLoadingIcon()
  {
    this._setIsLoading(true);
    this.showChildOrLoadingIcon();
  }

  void hideLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    hideLoadingIcon();
  }

  void hideLoadingIcon()
  {
    this._setIsLoading(false);
  }

  void showChildOrLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    showChildOrLoadingIcon();
  }

  void showChildOrLoadingIcon()
  {
    this._setHideAllChildren(false);
  }

  void hideChildAndLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    hideChildAndLoadingIcon();
  }

  void hideChildAndLoadingIcon()
  {
    this._setHideAllChildren(true);
  }



  bool childIsVisible()
  {
    return !this._isLoading;
  }

  bool childIsHidden()
  {
    return this._isLoading;
  }

  bool loadingIconIsVisible()
  {
    return this._isLoading;
  }

  bool loadingIconIsHidden()
  {
    return !this._isLoading;
  }

  bool childOrLoadingIconIsVisible()
  {
    return !this._hideAllChildren;
  }

  bool childAndLoadingIconAreHidden()
  {
    return this._hideAllChildren;
  }


  @override
  State<StatefulWidget> createState()
  {
    this._state = ToggleableWidgetState(this._child,
                                        this._loadingIndicator,
                                        this._isLoading,
                                        this._showLoadingIndicatorOnLoading,
                                        this._hideAllChildren);
    return this._state;
  }
}



class ToggleableWidgetState extends State<ToggleableWidget>
{
  Widget _child;
  Widget _loadingIndicator;
  bool _isLoading;
  bool _showLoadingIndicatorOnLoading;
  bool _hideAllChildren;

  ToggleableWidgetState(this._child, this._loadingIndicator,
                        this._isLoading,
                        this._showLoadingIndicatorOnLoading,
                        this._hideAllChildren);



  void setIsLoading(bool isLoading)
  {
    setState(()
    {
      this._isLoading = isLoading;
    });
  }

  void setHideAllChildren(bool shouldHideAllChildren)
  {
    setState(()
    {
      this._hideAllChildren = shouldHideAllChildren;
    });
  }

  Widget _getDisplayWidget()
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

    else if (!_isLoading && !_hideAllChildren)
    {
      return _child;
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return _getDisplayWidget();
  }
}
