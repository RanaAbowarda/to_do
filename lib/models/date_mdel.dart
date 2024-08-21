import 'package:flutter/material.dart';

class DateModel {
  DateTime currentDate;
  DateModel({required this.currentDate});
  Future<void> selectedDate(
    BuildContext context,
  ) async {
    final DateTime? selectedDay = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDay != null) {
      currentDate = selectedDay;
    }
  }
}
