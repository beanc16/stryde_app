import 'package:Stryde/components/toggleableWidget/ToggleableWidgetBody.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidgetController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ToggleableWidget extends StatefulWidget
{
  late final Widget _child;
  late final Widget _loadingIndicator;
  late bool _showLoadingIndicatorOnLoading;
  late final ToggleableWidgetController _controller;


  ToggleableWidget({
    required Widget child,
    Widget? loadingIndicator,
    bool showLoadingIndicatorOnLoading = true,
    bool isLoading = false,
    bool hideOnStartup = false,
  })
  {
    this._child = child;
    this._showLoadingIndicatorOnLoading = showLoadingIndicatorOnLoading;
    this._controller = ToggleableWidgetController(
      isLoading: isLoading,
      hideOnStartup: hideOnStartup,
    );

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



  void setIsLoading(bool isLoading)
  {
    _controller.setIsLoading(isLoading);
  }

  void setHideAllChildren(bool shouldHideAllChildren)
  {
    _controller.setHideAllChildren(shouldHideAllChildren);
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
    this.setIsLoading(false);
    this.showChildOrLoadingIcon();
  }

  void hideChildAfter(Duration duration) async
  {
    await Future.delayed(duration);
    hideChild();
  }

  void hideChild()
  {
    this.setIsLoading(true);
  }

  void showLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    showLoadingIcon();
  }

  Future showLoadingIconFor(Duration duration) async
  {
    showLoadingIcon();
    await Future.delayed(duration);
    hideChildAndLoadingIcon();
  }

  void showLoadingIcon()
  {
    this.setIsLoading(true);
    this.showChildOrLoadingIcon();
  }

  void hideLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    hideLoadingIcon();
  }

  void hideLoadingIcon()
  {
    this.setIsLoading(false);
  }

  void showChildOrLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    showChildOrLoadingIcon();
  }

  void showChildOrLoadingIcon()
  {
    this.setHideAllChildren(false);
  }

  void hideChildAndLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    hideChildAndLoadingIcon();
  }

  void hideChildAndLoadingIcon()
  {
    this.setHideAllChildren(true);
  }



  bool childIsVisible()
  {
    return !_controller.isLoading;
  }

  bool childIsHidden()
  {
    return _controller.isLoading;
  }

  bool loadingIconIsVisible()
  {
    return _controller.isLoading;
  }

  bool loadingIconIsHidden()
  {
    return !_controller.isLoading;
  }

  bool childOrLoadingIconIsVisible()
  {
    return !_controller.hideAllChildren;
  }

  bool childAndLoadingIconAreHidden()
  {
    return _controller.hideAllChildren;
  }


  @override
  State<StatefulWidget> createState()
  {
    return ToggleableWidgetState(this._child,
                                 this._loadingIndicator,
                                 this._showLoadingIndicatorOnLoading,
                                 this._controller);
  }
}



class ToggleableWidgetState extends State<ToggleableWidget>
{
  Widget _child;
  Widget _loadingIndicator;
  bool _showLoadingIndicatorOnLoading;
  late bool _isLoading;
  late bool _hideAllChildren;
  final ToggleableWidgetController _controller;

  ToggleableWidgetState(this._child, this._loadingIndicator,
                        this._showLoadingIndicatorOnLoading,
                        this._controller)
  {
    this._isLoading = this._controller.isLoading;
    this._hideAllChildren = this._controller.hideAllChildren;

    _intializeListeners();
  }

  void _intializeListeners()
  {
    _controller.addListener(()
    {
      if (_controller.isLoading != this._isLoading)
      {
        setIsLoading(_controller.isLoading);
      }
    });

    _controller.addListener(()
    {
      if (_controller.hideAllChildren != this._hideAllChildren)
      {
        setHideAllChildren(_controller.hideAllChildren);
      }
    });
  }



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



  @override
  Widget build(BuildContext context)
  {
    return ToggleableWidgetBody(
      child: _child,
      loadingIndicator: _loadingIndicator,
      isLoading: _isLoading,
      showLoadingIndicatorOnLoading: _showLoadingIndicatorOnLoading,
      hideAllChildren: _hideAllChildren
    );
  }
}
