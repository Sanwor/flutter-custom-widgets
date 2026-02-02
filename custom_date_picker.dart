import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

Future<void> showCustomCupertinoDatePicker({
  required BuildContext context,
  required TextEditingController controller,
  DateTime? minDate,
  DateTime? maxDate,
  Color? headerColor,
  Color? cancelTextColor,
  Color? doneTextColor,
}) async {
  DateTime now = DateTime.now();

  DateTime selectedDateTime;

  if (controller.text.isNotEmpty) {
    try {
      selectedDateTime = DateFormat('yyyy-MM-dd').parse(controller.text);
    } catch (_) {
      selectedDateTime = now;
    }
  } else {
    selectedDateTime = now;
  }

  // 🔥 CRITICAL FIX: Ensure initialDateTime is within bounds
  if (minDate != null && selectedDateTime.isBefore(minDate)) {
    selectedDateTime = minDate;
  }

  if (maxDate != null && selectedDateTime.isAfter(maxDate)) {
    selectedDateTime = maxDate;
  }

  await showModalBottomSheet(
    context: context,
    builder: (_) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            Container(
              color: headerColor ?? Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    child: Text(
                      "cancel".tr,
                      style: TextStyle(fontSize: 16.0, color: cancelTextColor ?? red),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  MaterialButton(
                    child: Text(
                      "done".tr,
                      style: TextStyle(fontSize: 16.0, color: doneTextColor ?? txtBlue),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.text =
                          DateFormat('yyyy-MM-dd').format(selectedDateTime);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: selectedDateTime,
                minimumDate: minDate ?? DateTime(1900, 1, 1),
                maximumDate: maxDate ?? DateTime(3000, 1, 1),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDateTime) {
                  selectedDateTime = newDateTime;
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

