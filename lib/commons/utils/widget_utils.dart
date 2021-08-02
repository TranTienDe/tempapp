import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/constants/resource.dart';

showSnackBar(String title, String message) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP, backgroundColor: Colors.white60, colorText: Colors.black);
}

printText(Object? object) {
  if (!Resource.debug) return;
  print('TempApp: $object');
}
