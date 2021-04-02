import 'ToggleableWidget.dart';


class ToggleableWidgetMap<K>
{
  Map<K, ToggleableWidget> map;

  ToggleableWidgetMap(this.map);



  ToggleableWidget get(K key)
  {
    ToggleableWidget output = null;

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
    return map.values;
  }



  void showChildAfter(K key, Duration duration) async
  {
    map[key].showChildAfter(duration);
  }

  void showChildFor(K key, Duration duration)
  {
    map[key].showChildFor(duration);
  }

  void showChild(K key)
  {
    map[key].showChild();
  }

  void hideChildAfter(K key, Duration duration) async
  {
    map[key].hideChildAfter(duration);
  }

  void hideChild(K key)
  {
    map[key].hideChild();
  }

  void showLoadingIconAfter(K key, Duration duration) async
  {
    map[key].showLoadingIconAfter(duration);
  }

  void showLoadingIcon(K key)
  {
    map[key].showLoadingIcon();
  }

  void hideLoadingIconAfter(K key, Duration duration) async
  {
    map[key].hideLoadingIconAfter(duration);
  }

  void hideLoadingIcon(K key)
  {
    map[key].hideLoadingIcon();
  }

  void showChildOrLoadingIconAfter(K key, Duration duration) async
  {
    map[key].showChildOrLoadingIconAfter(duration);
  }

  void showChildOrLoadingIcon(K key)
  {
    map[key].showChildOrLoadingIcon();
  }

  void hideChildAndLoadingIconAfter(K key, Duration duration) async
  {
    map[key].hideChildAndLoadingIconAfter(duration);
  }

  void hideChildAndLoadingIcon(K key)
  {
    map[key].hideChildAndLoadingIcon();
  }



  bool childIsVisible(K key)
  {
    return map[key].childIsVisible();
  }

  bool childIsHidden(K key)
  {
    return map[key].childIsHidden();
  }

  bool loadingIconIsVisible(K key)
  {
    return map[key].loadingIconIsVisible();
  }

  bool loadingIconIsHidden(K key)
  {
    return map[key].loadingIconIsHidden();
  }

  bool childOrLoadingIconIsVisible(K key)
  {
    return map[key].childOrLoadingIconIsVisible();
  }

  bool childAndLoadingIconAreHidden(K key)
  {
    return map[key].childAndLoadingIconAreHidden();
  }



  @override
  String toString()
  {
    return map.toString();
  }
}