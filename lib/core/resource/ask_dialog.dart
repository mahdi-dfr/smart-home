import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/images.dart';

Future<void> askDialog(Function() onConfirm ){
  return Get.defaultDialog(
    title: "حذف پروژه",
    titleStyle: TextStyle(
      color: CustomColors.foregroundColor,
      fontWeight: FontWeight.bold,
    ),
    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Images.logo),
            fit: BoxFit.cover,
            opacity: 0.05),
      ),
      child: const Text(
        "آیا میخواهید حذف کنید؟",
        textAlign: TextAlign.center,
      ),
    ),
    actions: [
      ElevatedButton(
        onPressed: onConfirm,
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

