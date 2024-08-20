import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DialogModel {
  static void showLoding(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(15),
            content: Row(
              children: [
                const CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "loading...".tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      required String message,
      String title = "",
      String? posActionName,
      String? negActionName,
      Function? posAction,
      Function? negAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      // Add the action you need..
      actions.add(
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    if (negActionName != null) {
      // Add the action you need..
      actions.add(
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(15),
            content: Text(
              message,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            title: Text(title),
            actions: actions,
          );
        });
  }
}
