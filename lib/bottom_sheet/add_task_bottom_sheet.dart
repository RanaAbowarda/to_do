import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screens/my_theme_data.dart';

class AddTaskBootomSheet extends StatefulWidget {
  const AddTaskBootomSheet({super.key});

  @override
  State<AddTaskBootomSheet> createState() => _AddTaskBootomSheetState();
}

class _AddTaskBootomSheetState extends State<AddTaskBootomSheet> {
  TimeOfDay currentTime = TimeOfDay.now();
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
              selectedTime();
            },
            child: Text(currentTime.format(context).toString().tr(),
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
              onPressed: () {},
              child: Text("addTask ".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: MyThemeData.white)))
        ],
      ),
    );
  }

  Future<void> selectedTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (pickedTime != null && pickedTime != TimeOfDay.now()) {
      currentTime = pickedTime;
      setState(() {});
    }
  }
}
