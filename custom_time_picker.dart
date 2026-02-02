import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syuseiclub/src/app_config/app_styles.dart';

Future<void> showCustomCupertinoTimePicker({
  required BuildContext context,
  required TextEditingController controller,
  Color? headerColor,
  Color? cancelTextColor,
  Color? doneTextColor,
}) async {
  // Default time (current time or parsed from controller)
  TimeOfDay now = TimeOfDay.now();
  DateTime nowDateTime = DateTime.now();

  DateTime selectedDateTime;
  if (controller.text.isNotEmpty) {
    try {
      final parsedTime = DateFormat('HH:mm').parse(controller.text);
      selectedDateTime = DateTime(
        nowDateTime.year,
        nowDateTime.month,
        nowDateTime.day,
        parsedTime.hour,
        parsedTime.minute,
      );
    } catch (e) {
      selectedDateTime = DateTime(
        nowDateTime.year,
        nowDateTime.month,
        nowDateTime.day,
        now.hour,
        now.minute,
      );
    }
  } else {
    selectedDateTime = DateTime(
      nowDateTime.year,
      nowDateTime.month,
      nowDateTime.day,
      now.hour,
      now.minute,
    );
  }

  await showModalBottomSheet(
    context: context,
    builder: (_) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            // Header
            Container(
              color: headerColor ?? Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    child: Text(
                      "cancel".tr,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: cancelTextColor ?? red,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  MaterialButton(
                    child: Text(
                      "done".tr,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: doneTextColor ?? txtBlue,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.text =
                          DateFormat('HH:mm').format(selectedDateTime);
                    },
                  ),
                ],
              ),
            ),

            // Time Picker
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: selectedDateTime,
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
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
