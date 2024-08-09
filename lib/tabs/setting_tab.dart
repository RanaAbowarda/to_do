import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/drop_down_buttons/language_drop_down.dart';
import 'package:to_do/drop_down_buttons/mode_drop_down.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screens/my_theme_data.dart';

class SettingsTab extends StatefulWidget {
 const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "language".tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: provider.mode == ThemeMode.light
                      ? MyThemeData.black
                      : MyThemeData.white,
                ),
          ),
          const SizedBox(
            height: 30,
          ),
          const LanguageDropDown(),
          const SizedBox(
            height: 30,
          ),
          Text(
            "mode".tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: provider.mode == ThemeMode.light
                      ? MyThemeData.black
                      : MyThemeData.white,
                ),
          ),
          const SizedBox(
            height: 30,
          ),
          const ModeDropDown(),
        ],
      ),
    );
  }
}
