import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:workout_buddy/components/calendarHelpers/CalendarEvent.dart';
import 'package:workout_buddy/components/calendarHelpers/CalendarEventDataSource.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';


class WorkoutScheduleScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return WorkoutScheduleScreenState();
  }
}



class WorkoutScheduleScreenState extends State<WorkoutScheduleScreen>
{
  CalendarEventDataSource _calendarEventDataSource;

  WorkoutScheduleScreenState()
  {
    DateTime today = DateTime.now();
    DateTime startTime = DateTime(
      today.year,   // Year
      today.month,  // Month
      2,            // Day
      15,           // Hour
      0,            // Minute
      0             // Second
    );

    _calendarEventDataSource = CalendarEventDataSource.events([
      CalendarEvent.lasts("Test Event", startTime, Duration(hours: 1)),
    ]);

    _calendarEventDataSource.addEvent(
      "Test Event 2",
      startTime.add(Duration(days: 1)),
      startTime.add(Duration(days: 1, hours: 1)),
      backgroundColor: StrydeColors.purple
    );
  }



  @override
  Widget build(BuildContext context)
  {
    return SfCalendar(
      view: CalendarView.week,
      dataSource: _calendarEventDataSource,

      initialSelectedDate: DateTime.now(),
      showNavigationArrow: true,

      todayHighlightColor: StrydeColors.lightBlue,
    );
  }
}