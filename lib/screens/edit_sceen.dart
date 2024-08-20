import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/bottom_sheet/add_task_bottom_sheet.dart';
import 'package:to_do/custom/custom_button.dart';

import 'package:to_do/custom/custom_text_form_field.dart';
import 'package:to_do/models/date_mdel.dart';
import 'package:to_do/models/firebase_functions.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/themeing/my_theme_data.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});
  static const String routeName = "EditScreen";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime currentDate = DateTime.now();
  TaskModel? model;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    model = ModalRoute.of(context)?.settings.arguments as TaskModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "appBarTitle".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100,
              color: MyThemeData.secondaryColor,
            ),
            Center(
              child: Container(
                height: 617,
                width: 352,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyThemeData.white),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "ebitTask".tr(),
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
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomFormField(
                            label: "entertaskdetalis".tr(),
                            controller: subTitleController,
                            validator: (text) {
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("selectedTime".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: provider.mode == ThemeMode.light
                                        ? const Color(0xff383838)
                                        : MyThemeData.grayDarkColor),
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: InkWell(
                          onTap: () async {
                            DateModel dateModel =
                                DateModel(currentDate: currentDate);
                            await dateModel.selectedDate(context);
                            setState(() {
                              currentDate = dateModel.currentDate;
                            });
                          },
                          child: Text(
                              currentDate.toString().substring(0, 10).tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: MyThemeData.secondaryGrayColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      Column(children: [
                        CustomButton(
                            label: "saveChanges".tr(), onPressed: updateTask),
                      ]),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  updateTask() {
    model!.title = titleController.text;
    model!.subTitle = subTitleController.text;
    model!.date = DateUtils.dateOnly(currentDate).millisecondsSinceEpoch;
    FirebaseFunctions.updateTask(model!);
    Navigator.pop(context);
    setState(() {});
  }
}
