import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';

Future<void> questionDialog({
  required String title,
  required String question,
  required Function() onYesClicked,}
    ) {
  return Get.defaultDialog(
    title: title,
    titleStyle: TextStyle(
      color: CustomColors.foregroundColor,
      fontWeight: FontWeight.bold,
    ),
    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        question,
        textAlign: TextAlign.center,
      ),
    ),
    actions: [
      ElevatedButton(
        onPressed: onYesClicked,
        style: ElevatedButton.styleFrom(
          primary: CustomColors.foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Container(
          width: 100,
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            "بله",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          // Handle the "No" button press here
          Get.back(result: "No");
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Container(
          width: 100,
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            "خیر",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ],
  );
}
