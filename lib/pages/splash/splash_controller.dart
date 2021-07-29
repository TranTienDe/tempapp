import 'package:get/get.dart';
import 'package:tempapp/commons/routers/app_pages.dart';
import 'package:tempapp/commons/storages/user_storage.dart';
import 'package:tempapp/commons/utils/widget_utils.dart';

class SplashController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    getLoginState();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getLoginState() async {
    try {
      isLoading(true);
      await Future.delayed(
        Duration(seconds: 3),
        () async {
          bool isLogin = await UserStorage.getLoginState();
          if (isLogin)
            Get.offAllNamed(Paths.Dashboard);
          else
            Get.offAllNamed(Paths.Login);
        },
      );
    } catch (ex) {
      showSnackBar("Error", ex.toString());
    } finally {
      isLoading(false);
    }
  }
}
