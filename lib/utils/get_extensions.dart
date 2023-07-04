import 'package:eurosom_admin/res/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

viewSnackBar(String message, {Color? color}) {
  Get.showSnackbar(
    GetSnackBar(
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color ?? Colors.black,
    ),
  );
}

showAlertDialog(String title, String msg) {
  Get.defaultDialog(
      titleStyle: TextStyle(fontSize: 16),
      radius: 10,
      backgroundColor: AppColor.white,
      title: title,
      content: Icon(Icons.clear),
      middleText: msg,
      textConfirm: 'Update',
      buttonColor: AppColor.themeColor,
      actions: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please choose the plan'),
            ],
          ),
        )
      ]);
}

showModelBottomSheet() {
  Get.bottomSheet(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'Hello!, I Am Getx Bottom Sheet',
            style: TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
