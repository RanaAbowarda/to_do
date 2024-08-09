import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screens/my_theme_data.dart';

class TaskItems extends StatelessWidget {
  const TaskItems({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
              backgroundColor: const Color(0xFFFE4A49),
              icon: Icons.delete,
              label: 'delete'.tr(),
              spacing: 8,
              onPressed: (context) {}),
          SlidableAction(
              backgroundColor: MyThemeData.secondaryColor,
              foregroundColor: MyThemeData.white,
              icon: Icons.edit,
              label: 'edit'.tr(),
              spacing: 8,
              onPressed: (context) {}),
        ],
      ),
      child: Container(
          height: 115,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: provider.mode == ThemeMode.light
                ? MyThemeData.white
                : MyThemeData.secondaryDarkColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 62,
                width: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyThemeData.secondaryColor),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "taskTitle".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: MyThemeData.secondaryColor),
                    ),
                    Text(
                      "taskDescription".tr(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyThemeData.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Icon(
                  Icons.done,
                  size: 30,
                  color: MyThemeData.white,
                ),
              )
            ],
          )),
    );
  }
}
