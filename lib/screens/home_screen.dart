import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/bottom_sheet/add_task_bottom_sheet.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/themeing/my_theme_data.dart';
import 'package:to_do/tabs/setting_tab.dart';
import 'package:to_do/tabs/task_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "appBarTitle".tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: provider.mode == ThemeMode.light
                  ? MyThemeData.white
                  : MyThemeData.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: provider.mode == ThemeMode.light
                  ? MyThemeData.white
                  : MyThemeData.secondaryDarkColor,
              context: context,
              isScrollControlled: true,
              builder: (context) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const AddTaskBootomSheet(),
                  ));
        },
        child: Icon(
          Icons.add,
          color: MyThemeData.white,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Background color of BottomAppBar
          boxShadow: [
            BoxShadow(
              color: provider.mode == ThemeMode.dark
                  ? const Color(0xff56D7BC).withOpacity(0.2)
                  : Colors.transparent, // Shadow color
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, -4), // Shadow position
            ),
          ],
        ),
        child: BottomAppBar(
          notchMargin: 8,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (value) {
                selectedIndex = value;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.home), label: "home".tr()),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.settings_outlined),
                    label: "settings".tr())
              ]),
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    const TasksTab(),
    const SettingsTab(),
  ];
}
