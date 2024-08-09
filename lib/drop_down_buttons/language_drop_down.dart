import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screens/my_theme_data.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({super.key});

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  String? valueChoose;
  List<String> languages = ["arabic", "english"];
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
        ),
        iconEnabledColor: MyThemeData.secondaryColor,
        dropdownColor: provider.mode == ThemeMode.dark
            ? MyThemeData.primaryDarkColor
            : MyThemeData.primaryColor,
        value: valueChoose,
        hint: Text( 
          context.tr('selectlanguage'),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: MyThemeData.secondaryColor,
              ),
        ),
        items: languages.map((valueItem) {
          return DropdownMenuItem(
              value: valueItem,
              child: Text(
                valueItem.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: MyThemeData.secondaryColor),
              ));
        }).toList(),
        onChanged: (newValue) {
          valueChoose = newValue;
          if (valueChoose == languages[0]) {
            context.setLocale( const Locale('ar'));
          } else if (valueChoose == languages[1]) {
            context.setLocale( const Locale('en'));
          }
          setState(() {});
        });
  }
}
