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



  Future setIsLoading(bool isLoading) async
  {
    await _controller.setIsLoading(isLoading);
    return Future;
  }

  Future setHideAllChildren(bool shouldHideAllChildren) async
  {
    await _controller.setHideAllChildren(shouldHideAllChildren);
    return Future;
  }

  Future showChildAfter(Duration duration) async
  {
    await Future.delayed(duration);
    await showChild();
    return Future;
  }

  Future showChildFor(Duration duration) async
  {
    await showChild();
    await Future.delayed(duration);
    await hideChildAndLoadingIcon();
    return Future;
  }

  Future showChild() async
  {
    await this.setIsLoading(false);
    await this.showChildOrLoadingIcon();
    return Future;
  }

  Future hideChildAfter(Duration duration) async
  {
    await Future.delayed(duration);
    await hideChild();
    return Future;
  }

  Future hideChild() async
  {
    await this.setIsLoading(true);
    return Future;
  }

  Future showLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    await showLoadingIcon();
    return Future;
  }

  Future showLoadingIconFor(Duration duration) async
  {
    await showLoadingIcon();
    await Future.delayed(duration);
    await hideChildAndLoadingIcon();
    return Future;
  }

  Future showLoadingIcon() async
  {
    await this.setIsLoading(true);
    await this.showChildOrLoadingIcon();
    return Future;
  }

  Future hideLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    await hideLoadingIcon();
    return Future;
  }

  Future hideLoadingIcon() async
  {
    await this.setIsLoading(false);
    return Future;
  }

  Future showChildOrLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    await showChildOrLoadingIcon();
    return Future;
  }

  Future showChildOrLoadingIcon() async
  {
    await this.setHideAllChildren(false);
    return Future;
  }

  Future hideChildAndLoadingIconAfter(Duration duration) async
  {
    await Future.delayed(duration);
    await hideChildAndLoadingIcon();
    return Future;
  }

  Future hideChildAndLoadingIcon() async
  {
    await this.setHideAllChildren(true);
    return Future;
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
