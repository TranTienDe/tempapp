import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/pages/dashboard/setting/setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Thiết lập'),
      ),
    );
  }
}
