import 'package:get/get.dart';
import 'package:tempapp/pages/dashboard/account/account_controller.dart';
import 'package:tempapp/pages/dashboard/dashboard_controller.dart';
import 'package:tempapp/pages/dashboard/home/home_controller.dart';
import 'package:tempapp/pages/dashboard/setting/setting_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
