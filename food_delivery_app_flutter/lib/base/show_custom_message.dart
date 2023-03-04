import 'package:flutter/material.dart';
import 'package:food_delivery_app_flutter/utils/app_constants.dart';
import 'package:food_delivery_app_flutter/utils/dimensions.dart';
import 'package:food_delivery_app_flutter/widgets/big_text.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
    String title = "Error",
    Color color = Colors.redAccent}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: title,
        color: Colors.white,
      ),
      messageText: Text(message,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400)),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color);
}
