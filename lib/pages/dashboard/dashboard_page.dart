import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/pages/base_page.dart';
import 'package:tempapp/pages/dashboard/account/account_page.dart';
import 'package:tempapp/pages/dashboard/dashboard_controller.dart';
import 'package:tempapp/pages/dashboard/home/home_page.dart';
import 'package:tempapp/pages/dashboard/setting/setting_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      builder: (context, sizeInfo) {
        return GetBuilder<DashboardController>(builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                  child: IndexedStack(
                index: controller.tabIndex,
                children: [HomePage(), SettingPage(), AccountPage()],
              )),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              onTap: (index) => controller.onTabChanged(index),
              currentIndex: controller.tabIndex,
              selectedIconTheme: IconThemeData(color: Colors.red, opacity: 1.0, size: 30.0),
              unselectedIconTheme: IconThemeData(color: Colors.black45, opacity: 1.0, size: 24.0),
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chính'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Thiết lập'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản')
              ],
            ),
          );
        });
      },
    );
  }
}
