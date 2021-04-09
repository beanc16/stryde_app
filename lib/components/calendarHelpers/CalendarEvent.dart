import 'dart:ui';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';


class CalendarEvent
{
  String eventName;
  DateTime startTime;
  late DateTime endTime;
  Color? backgroundColor;
  late bool isAllDay;

  CalendarEvent(this.eventName,  this.startTime, this.endTime,
                {Color? backgroundColor = StrydeColors.darkBlue})
  {
    this.backgroundColor = backgroundColor;
    this.isAllDay = false;
  }

  CalendarEvent.lasts(this.eventName, this.startTime, Duration duration,
                      {Color backgroundColor = StrydeColors.darkBlue})
  {
    this.endTime = this.startTime.add(duration);
    this.backgroundColor = backgroundColor;
    this.isAllDay = false;
  }
}

