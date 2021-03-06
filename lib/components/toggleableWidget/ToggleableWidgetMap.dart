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



  void showChildAfter(K key, Duration duration)
  {
    map[key]?.showChildAfter(duration);
  }

  void showChildFor(K key, Duration duration)
  {
    map[key]?.showChildFor(duration);
  }

  void showChild(K key)
  {
    map[key]?.showChild();
  }

  void hideChildAfter(K key, Duration duration)
  {
    map[key]?.hideChildAfter(duration);
  }

  void hideChild(K key) async
  {
    map[key]?.hideChild();
  }

  void showLoadingIconAfter(K key, Duration duration)
  {
    map[key]?.showLoadingIconAfter(duration);
  }

  void showLoadingIconFor(K key, Duration duration)
  {
    map[key]?.showLoadingIconFor(duration);
  }

  void showLoadingIcon(K key)
  {
    map[key]?.showLoadingIcon();
  }

  void hideLoadingIconAfter(K key, Duration duration)
  {
    map[key]?.hideLoadingIconAfter(duration);
  }

  void hideLoadingIcon(K key)
  {
    map[key]?.hideLoadingIcon();
  }

  void showChildOrLoadingIconAfter(K key, Duration duration)
  {
    map[key]?.showChildOrLoadingIconAfter(duration);
  }

  void showChildOrLoadingIcon(K key)
  {
    map[key]?.showChildOrLoadingIcon();
  }

  void hideChildAndLoadingIconAfter(K key, Duration duration)
  {
    map[key]?.hideChildAndLoadingIconAfter(duration);
  }

  void hideChildAndLoadingIcon(K key)
  {
    map[key]?.hideChildAndLoadingIcon();
  }

  void hideAll()
  {
    Future.forEach(map.entries, (MapEntry entry)
    {
      map[key]?.hideChild();
    });
  }

  void hideAllExcept(String dontHide)
  {
    map.forEach((key, value)
    {
      if (key != dontHide)
      {
        map[key]?.hideChild();
      }
    });
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