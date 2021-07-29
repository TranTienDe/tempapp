import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String title, String message) {
  Get.snackbar(title, message, snackPosition: SnackPosition.TOP, backgroundColor: Colors.white60, colorText: Colors.black);
}
