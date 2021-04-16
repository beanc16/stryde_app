import 'package:Stryde/screens/ComingSoonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:Stryde/components/calendarHelpers/CalendarEvent.dart';
import 'package:Stryde/components/calendarHelpers/CalendarEventDataSource.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';


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
  late final CalendarEventDataSource _calendarEventDataSource;

  WorkoutScheduleScreenState()
  {
    DateTime today = DateTime.now();
    DateTime startTime = DateTime(
      today.year,       // Year
      today.month,      // Month
      today.day,        // Day
      today.hour + 1,   // Hour
      0,                // Minute
      0                 // Second
    );

    _calendarEventDataSource = CalendarEventDataSource.events([
      CalendarEvent.lasts("My First Workout", startTime, Duration(hours: 1)),
    ]);

    _calendarEventDataSource.addEvent(
      "My Second Workout",
      startTime.add(Duration(days: 2)),
      startTime.add(Duration(days: 2, hours: 1)),
      backgroundColor: StrydeColors.purple
    );
  }



  @override
  Widget build(BuildContext context)
  {
    return Stack(
      children: [
        SfCalendar(
          view: CalendarView.week,
          dataSource: _calendarEventDataSource,

          initialSelectedDate: DateTime.now(),
          showNavigationArrow: true,

          todayHighlightColor: StrydeColors.lightBlue,
        ),
        ComingSoonWidget(),
      ]
    );
  }
}