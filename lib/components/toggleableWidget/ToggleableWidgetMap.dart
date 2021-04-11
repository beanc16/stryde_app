import 'package:flutter/cupertino.dart';

import 'ToggleableWidget.dart';


class ToggleableWidgetMap<K> extends StatelessWidget
{
  Map<K, ToggleableWidget> map;
  late MainAxisAlignment _mainAxisAlignment;
  late CrossAxisAlignment _crossAxisAlignment;

  ToggleableWidgetMap(this.map, {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  })
  {
    _mainAxisAlignment = mainAxisAlignment;
    _crossAxisAlignment = crossAxisAlignment;
  }



  ToggleableWidget? get(K key)
  {
    ToggleableWidget? output;

    map.forEach((k, v)
    {
      if (key == k)
      {
        output = v;
        return;
      }
    });

    return output;
  }

  void add(K key, ToggleableWidget value)
  {
    map.addAll({key: value});
  }

  void addAll(Map<K, ToggleableWidget> map)
  {
    this.map.addAll(map);
  }

  void remove(K key)
  {
    map.remove(key);
  }

  int length()
  {
    return map.length;
  }

  void clear()
  {
    map.clear();
  }

  bool containsKey(K key)
  {
    return map.containsKey(key);
  }

  bool containsValue(ToggleableWidget value)
  {
    return map.containsValue(value);
  }

  List<ToggleableWidget> toList()
  {
    return map.values.toList();
  }



  Future showChildAfter(K key, Duration duration) async
  {
    await map[key]?.showChildAfter(duration);
    return Future;
  }

  Future showChildFor(K key, Duration duration) async
  {
    await map[key]?.showChildFor(duration);
    return Future;
  }

  Future showChild(K key) async
  {
    await map[key]?.showChild();
    return Future;
  }

  Future hideChildAfter(K key, Duration duration) async
  {
    await map[key]?.hideChildAfter(duration);
    return Future;
  }

  Future hideChild(K key) async
  {
    await map[key]?.hideChild();
    return Future;
  }

  Future showLoadingIconAfter(K key, Duration duration) async
  {
    await map[key]?.showLoadingIconAfter(duration);
    return Future;
  }

  Future showLoadingIconFor(K key, Duration duration) async
  {
    await map[key]?.showLoadingIconFor(duration);
    return Future;
  }

  Future showLoadingIcon(K key) async
  {
    await map[key]?.showLoadingIcon();
    return Future;
  }

  Future hideLoadingIconAfter(K key, Duration duration) async
  {
    await map[key]?.hideLoadingIconAfter(duration);
    return Future;
  }

  Future hideLoadingIcon(K key) async
  {
    await map[key]?.hideLoadingIcon();
    return Future;
  }

  Future showChildOrLoadingIconAfter(K key, Duration duration) async
  {
    await map[key]?.showChildOrLoadingIconAfter(duration);
    return Future;
  }

  Future showChildOrLoadingIcon(K key) async
  {
    await map[key]?.showChildOrLoadingIcon();
    return Future;
  }

  Future hideChildAndLoadingIconAfter(K key, Duration duration) async
  {
    await map[key]?.hideChildAndLoadingIconAfter(duration);
    return Future;
  }

  Future hideChildAndLoadingIcon(K key) async
  {
    await map[key]?.hideChildAndLoadingIcon();
    return Future;
  }

  Future hideAll() async
  {
    map.forEach((key, value) async
    {
      await map[key]?.hideChild();
    });

    return Future;
  }

  Future hideAllExcept(String dontHide) async
  {
    map.forEach((key, value) async
    {
      if (key != dontHide)
      {
        await map[key]?.hideChild();
      }
    });

    return Future;
  }



  bool childIsVisible(K key)
  {
    bool? result = map[key]?.childIsVisible();

    if (result == null)
    {
      return false;
    }

    return result;
  }

  bool childIsHidden(K key)
  {
    bool? result = map[key]?.childIsHidden();

    if (result == null)
    {
      return false;
    }

    return result;
  }

  bool loadingIconIsVisible(K key)
  {
    bool? result = map[key]?.loadingIconIsVisible();

    if (result == null)
    {
      return false;
    }

    return result;
  }

  bool loadingIconIsHidden(K key)
  {
    bool? result = map[key]?.loadingIconIsHidden();

    if (result == null)
    {
      return false;
    }

    return result;
  }

  bool childOrLoadingIconIsVisible(K key)
  {
    bool? result = map[key]?.childOrLoadingIconIsVisible();

    if (result == null)
    {
      return false;
    }

    return result;
  }

  bool childAndLoadingIconAreHidden(K key)
  {
    bool? result = map[key]?.childAndLoadingIconAreHidden();

    if (result == null)
    {
      return false;
    }

    return result;
  }



  @override
  String toString({DiagnosticLevel? minLevel})
  {
    return map.toString();
  }

  @override
  Widget build(BuildContext context)
  {
    return Row(
      mainAxisAlignment: _mainAxisAlignment,
      crossAxisAlignment: _crossAxisAlignment,
      children: map.values.toList(),
    );
  }
}