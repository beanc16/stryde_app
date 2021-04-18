import 'package:Stryde/components/toggleableWidget/EmptyWidget.dart';
import 'package:flutter/cupertino.dart';


class EmptyWidgetWithData extends EmptyWidget
{
  final dynamic data;

  EmptyWidgetWithData({required this.data, Key? key}) :
    super(key: key);
}
