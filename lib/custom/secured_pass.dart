import 'package:flutter/material.dart';
import 'package:to_do/themeing/my_theme_data.dart';

class SecuredPassword extends StatefulWidget {
  const SecuredPassword({super.key});

  @override
  State<SecuredPassword> createState() => _SecuredPasswordState();
}
  bool isSecured = true;
class _SecuredPasswordState extends State<SecuredPassword> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          isSecured = !isSecured;
          setState(() {});
        },
        icon: isSecured
            ? Icon(
                Icons.visibility,
                color: MyThemeData.secondaryColor,
              )
            : Icon(
                Icons.visibility_off,
                color: MyThemeData.secondaryColor,
              ));
  }
}