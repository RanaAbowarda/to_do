import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/firebase_functions.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screens/my_theme_data.dart';
import 'package:to_do/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 100,
              color: MyThemeData.secondaryColor,
            ),
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {},
              activeColor: provider.mode == ThemeMode.light
                  ? const Color(0xff85A389)
                  : MyThemeData.primaryColor,
              dayProps: EasyDayProps(
                todayHighlightStyle: TodayHighlightStyle.withBackground,
                todayHighlightColor: MyThemeData.white,
                inactiveDayStyle: DayStyle(
                    monthStrStyle: TextStyle(
                      fontSize: 11,
                      color: provider.mode == ThemeMode.light
                          ? MyThemeData.grayDarkColor
                          : MyThemeData.black,
                    ),
                    decoration: BoxDecoration(
                        color: MyThemeData.white,
                        borderRadius: BorderRadius.circular(10))),
              ),
              locale: Localizations.localeOf(context).toString(),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        StreamBuilder(
            stream: FirebaseFunctions.getTasks(date),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      Text("somethingWrong".tr()),
                      ElevatedButton(
                          onPressed: () {}, child: Text("tryagain"..tr()))
                    ],
                  ),
                );
              }
              var tasks = snapshot.data!.docs.map((doc) => doc.data()).toList();
              if (tasks.isEmpty) {
                return Center(
                    child: Text(
                  "noTasks".tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: provider.mode == ThemeMode.light
                          ? MyThemeData.black
                          : MyThemeData.white),
                ));
              }
              return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => TaskItems(
                            taskModel: tasks[index],
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                      itemCount: tasks.length));
            })
      ],
    );
  }
}
