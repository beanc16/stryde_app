import 'dart:ui';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'CalendarEvent.dart';


class CalendarEventDataSource extends CalendarDataSource
{
  CalendarEventDataSource()
  {
    super.appointments = [];
  }

  CalendarEventDataSource.events(List<CalendarEvent> events)
  {
    super.appointments = events;
  }



  // Events
  List<CalendarEvent> getEvents()
  {
    return appointments;
  }

  void addCalendarEvent(CalendarEvent event)
  {
    appointments.add(event);
  }

  void addEvent(String eventName, DateTime to, DateTime from,
                {Color backgroundColor})
  {
    CalendarEvent event = CalendarEvent(
      eventName, to, from,
      backgroundColor: backgroundColor
    );
    this.addCalendarEvent(event);
  }

  void removeEvent(CalendarEvent event)
  {
    appointments.remove(event);
  }



  // Other
  @override
  DateTime getStartTime(int index)
  {
    return appointments[index].startTime;
  }

  @override
  DateTime getEndTime(int index)
  {
    return appointments[index].endTime;
  }

  @override
  String getSubject(int index)
  {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index)
  {
    return appointments[index].backgroundColor;
  }

  @override
  bool isAllDay(int index)
  {
    return appointments[index].isAllDay;
  }
}