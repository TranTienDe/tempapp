import 'package:get/get.dart';

class DashboardController extends GetxController {
  int tabIndex = 0;

  void onTabChanged(int index) {
    tabIndex = index;
    update();
  }
}
