import 'dart:ui';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';


class CalendarEvent
{
  String eventName;
  DateTime startTime;
  DateTime endTime;
  Color backgroundColor;
  bool isAllDay;

  CalendarEvent(this.eventName,  this.startTime, this.endTime,
                {Color backgroundColor = StrydeColors.darkBlue})
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

