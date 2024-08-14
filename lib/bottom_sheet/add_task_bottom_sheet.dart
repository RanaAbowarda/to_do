import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:to_do/models/firebase_functions.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screens/my_theme_data.dart';

class AddTaskBootomSheet extends StatefulWidget {
  const AddTaskBootomSheet({super.key});

  @override
  State<AddTaskBootomSheet> createState() => _AddTaskBootomSheetState();
}

var titleController = TextEditingController();
var subTitleController = TextEditingController();

class _AddTaskBootomSheetState extends State<AddTaskBootomSheet> {
  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "addNewTask".tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: provider.mode == ThemeMode.light
                      ? MyThemeData.black
                      : MyThemeData.white,
                ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller: titleController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: MyThemeData.grayDarkColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: MyThemeData.secondaryColor)),
                    hintText: "enteryourtask".tr(),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: MyThemeData.secondaryGrayColor))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller: subTitleController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: MyThemeData.grayDarkColor)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyThemeData.secondaryColor),
                    ),
                    hintText: "entertaskdetalis".tr(),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: MyThemeData.secondaryGrayColor))),
          ),
          Text(
            "selectedTime".tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: provider.mode == ThemeMode.light
                    ? const Color(0xff383838)
                    : MyThemeData.grayDarkColor),
            textAlign: TextAlign.start,
          ),
          InkWell(
            onTap: () {
              selectedDate();
            },
            child: Text(currentDate.toString().substring(0, 10).tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: MyThemeData.secondaryGrayColor)),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyThemeData.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                TaskModel task = TaskModel(
                    title: titleController.text,
                    subTitle: subTitleController.text,
                    date:
                        DateUtils.dateOnly(currentDate).millisecondsSinceEpoch);
                FirebaseFunctions.addTask(task);
                Navigator.pop(context);
              },
              child: Text("addTask ".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: MyThemeData.white)))
        ],
      ),
    );
  }

  Future<void> selectedDate() async {
    final DateTime? selectedDay = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: MyThemeData.secondaryColor,
                onPrimary: MyThemeData.secondaryDarkGrayColor,
                onSurface: MyThemeData.secondaryDarkColor,
                surface: MyThemeData.primaryColor),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    MyThemeData.secondaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDay != null) {
      currentDate = selectedDay;
      setState(() {});
    }
  }
}
