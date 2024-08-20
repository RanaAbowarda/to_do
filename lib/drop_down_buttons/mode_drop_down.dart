import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/themeing/my_theme_data.dart';

class ModeDropDown extends StatefulWidget {
  const ModeDropDown({super.key});

  @override
  State<ModeDropDown> createState() => _ModeDropDownState();
}

class _ModeDropDownState extends State<ModeDropDown> {
  String? valueChoose;
  List<String> mode = ["light", "dark"];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return DropdownButtonFormField(
        decoration: InputDecoration(
            filled: true,
            fillColor: provider.mode == ThemeMode.dark
                ? MyThemeData.secondaryDarkColor
                : MyThemeData.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: MyThemeData.secondaryColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyThemeData.secondaryColor)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyThemeData.secondaryColor))),
        iconEnabledColor: MyThemeData.secondaryColor,
        dropdownColor: provider.mode == ThemeMode.dark
            ? MyThemeData.primaryDarkColor
            : MyThemeData.primaryColor,
        value: valueChoose,
        hint: Text(
          context.tr("selectMode"),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: MyThemeData.secondaryColor,
              ),
        ),
        items: mode.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(
              valueItem.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: MyThemeData.secondaryColor),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          valueChoose = newValue;
          if (valueChoose == mode[0]) {
            provider.changeTheme(ThemeMode.light);
          } else if (valueChoose == mode[1]) {
            provider.changeTheme(ThemeMode.dark);
          }
          setState(() {});
        });
  }
}
