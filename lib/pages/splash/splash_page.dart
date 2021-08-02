import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/pages/base_page.dart';
import 'package:tempapp/pages/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(builder: (context, sizeInfo) {
      return Material(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    width: sizeInfo.screenSize.width * 0.23,
                    height: sizeInfo.screenSize.width * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/logo_400.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Obx(
                              () => (controller.isLoading.value)
                                  ? CircularProgressIndicator(color: Colors.red)
                                  : CircularProgressIndicator(
                                      color: Colors.red, value: 100),
                            ),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                              text: '© Copyright by ',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.blue,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: 'iCarevn!',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold))
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
