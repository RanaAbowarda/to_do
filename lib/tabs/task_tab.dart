
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screens/my_theme_data.dart';
import 'package:to_do/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: provider.mode == ThemeMode.light
              ? MyThemeData.secondaryGrayColor
              : MyThemeData.white,
          dayColor: provider.mode == ThemeMode.light
              ? MyThemeData.secondaryColor
              : MyThemeData.white,
          activeDayColor: MyThemeData.white,
          activeBackgroundDayColor: MyThemeData.secondaryColor,
          dotsColor: MyThemeData.white,
          selectableDayPredicate: (date) => date.day != 23,
          locale: Localizations.localeOf(context).toString(),
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => const TaskItems(),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                itemCount: 30))
      ],
    );
  }
}
