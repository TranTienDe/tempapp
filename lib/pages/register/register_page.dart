import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/pages/base_page.dart';
import 'package:tempapp/pages/register/register_controller.dart';
import 'package:tempapp/pages/register/widgets/name_phone_page.dart';
import 'package:tempapp/pages/register/widgets/verify_password_page.dart';
import 'package:tempapp/pages/register/widgets/verify_sms_page.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(builder: (context, sizeInfo) {
      return Scaffold(
        appBar: AppBar(title: Text(Resource.str_register)),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: sizeInfo.screenSize.width / 10.0, right: sizeInfo.screenSize.width / 10.0, top: sizeInfo.screenSize.height / 25.0),
            child: Container(
              child: Obx(
                () => (controller.currState.value == RegisterState.show_phone_state)
                    ? NamePhonePage(controller: controller, sizeInfo: sizeInfo)
                    : (controller.currState.value == RegisterState.show_verify_sms_state)
                        ? VerifySmsPage(controller: controller, sizeInfo: sizeInfo)
                        : VerifyPasswordPage(controller: controller, sizeInfo: sizeInfo),
              ),
            ),
          ),
        ),
      );
    });
  }
}
