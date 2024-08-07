import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
  initialDate: DateTime.now(),
  firstDate: DateTime.now().subtract (const Duration(days:365 )),
  lastDate: DateTime.now().add(const Duration(days:365 )),
  onDateSelected: (date) => print(date),
  leftMargin: 20,
  monthColor: Colors.blueGrey,
  dayColor: Colors.teal[200],
  activeDayColor: Colors.white,
  activeBackgroundDayColor: Colors.redAccent[100],
  dotsColor: Color(0xFF333A47),
  selectableDayPredicate: (date) => date.day != 23,
  locale: 'en_ISO',
)
      ],
    );
  }
}