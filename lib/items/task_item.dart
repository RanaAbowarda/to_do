import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/firebase_functions.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screens/edit_sceen.dart';
import 'package:to_do/themeing/my_theme_data.dart';

class TaskItems extends StatelessWidget {
  TaskModel taskModel;
  TaskItems({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(
      margin: const EdgeInsets.all(15),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                backgroundColor: const Color(0xFFFE4A49),
                icon: Icons.delete,
                label: 'delete'.tr(),
                spacing: 8,
                onPressed: (context) {
                  FirebaseFunctions.deleteTask(taskModel.id);
                }),
            SlidableAction(
                backgroundColor: MyThemeData.secondaryColor,
                foregroundColor: MyThemeData.white,
                icon: Icons.edit,
                label: 'edit'.tr(),
                spacing: 8,
                onPressed: (context) {
                  Navigator.pushNamed(context, EditScreen.routeName,
                      arguments: (taskModel));
                }),
          ],
        ),
        child: Container(
            height: 115,
            width: double.infinity,
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
                      color: taskModel.isDone
                          ? Colors.green
                          : MyThemeData.secondaryColor),
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
                        taskModel.title.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: taskModel.isDone
                                ? Colors.green
                                : MyThemeData.secondaryColor),
                      ),
                      Text(
                        taskModel.subTitle.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                taskModel.isDone
                    ? Text(
                        "done !".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.green),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          taskModel.isDone = true;
                          FirebaseFunctions.updateTask(taskModel);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: taskModel.isDone
                                ? Colors.green
                                : MyThemeData.secondaryColor,
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
      ),
    );
  }
}
