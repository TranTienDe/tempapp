import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/pages/base_page.dart';
import 'package:tempapp/pages/login/login_controller.dart';
import 'package:tempapp/pages/login/widgets/body_widget.dart';
import 'package:tempapp/pages/login/widgets/logo_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(builder: (context, sizeInfo) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              width: sizeInfo.screenSize.width,
              height: sizeInfo.screenSize.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoWidget(sizeInfo: sizeInfo),
                    BodyWidget(controller: controller, sizeInfo: sizeInfo),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
