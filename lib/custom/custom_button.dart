import 'package:flutter/material.dart';
import 'package:to_do/themeing/my_theme_data.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.label, required this.onPressed});
  String label;
   VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyThemeData.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed:onPressed,
        child: Text(label, style: Theme.of(context).textTheme.titleMedium));
  }
}
