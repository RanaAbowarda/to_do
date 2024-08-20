import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:to_do/authentication/registeration.dart';
import 'package:to_do/custom/custom_button.dart';
import 'package:to_do/custom/custom_text_form_field.dart';
import 'package:to_do/models/date_mdel.dart';
import 'package:to_do/models/firebase_functions.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/themeing/my_theme_data.dart';

class AddTaskBootomSheet extends StatefulWidget {
  const AddTaskBootomSheet({super.key});

  @override
  State<AddTaskBootomSheet> createState() => _AddTaskBootomSheetState();
}
DateTime currentDate=DateTime.now();
var titleController = TextEditingController();
var subTitleController = TextEditingController();

class _AddTaskBootomSheetState extends State<AddTaskBootomSheet> {
  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: formKey,
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
              child: CustomFormField(
                label: "enteryourtask".tr(),
                controller: titleController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return ("Please enter task title");
                  }
                  return null;
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomFormField(
                  label: "entertaskdetalis".tr(),
                  controller: subTitleController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return ("Please enter task detalis");
                    }
                    return null;
                  },
                )),
            Text(
              "selectedTime".tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: provider.mode == ThemeMode.light
                      ? const Color(0xff383838)
                      : MyThemeData.grayDarkColor),
              textAlign: TextAlign.start,
            ),
            InkWell(
              onTap: ()async {
                DateModel dateModel = DateModel(currentDate: currentDate);
                await dateModel.selectedDate(context);
                setState(() {
                  currentDate = dateModel.currentDate;
                });},
              child: Text(
                 currentDate.toString().substring(0, 10).tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: MyThemeData.secondaryGrayColor)),
            ),
            CustomButton(
              label: "addTask ".tr(),
              onPressed: addTask,
            )
          ],
        ),
      ),
    );
  }

  addTask() {
    if (formKey.currentState?.validate() == true) {
      TaskModel task = TaskModel(
          title: titleController.text,
          subTitle: subTitleController.text,
          date: DateUtils.dateOnly(currentDate).millisecondsSinceEpoch);
      FirebaseFunctions.addTask(task);
      Navigator.pop(context);
    }
  }
}
