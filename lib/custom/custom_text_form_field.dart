import 'package:flutter/material.dart';
import 'package:to_do/themeing/my_theme_data.dart';

typedef MyValidator = String? Function(String?);

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {super.key,
      required this.label,
      required this.controller,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.suffixIcon});
  TextEditingController controller = TextEditingController();
  String label;
  MyValidator validator;
  TextInputType keyboardType;
  bool obscureText;
  Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyMedium,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: MyThemeData.secondaryColor, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: MyThemeData.secondaryColor, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 2)),
          label: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: MyThemeData.secondaryDarkGrayColor),
          ),
        ),
      ),
    );
  }
}
