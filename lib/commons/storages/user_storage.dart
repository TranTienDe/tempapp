import 'package:get_storage/get_storage.dart';

class UserStorage {
  static Future<bool> getLoginState() async {
    return await GetStorage().read('state_login_key') ?? false;
  }

  static Future<void> saveLoginState(bool value) async {
    return await GetStorage().write('state_login_key', value);
  }

  static Future<void> saveUserLogin(String userModel) async {
    return await GetStorage().write('user_login_key', userModel);
  }

  static Future<String> getUserLogin() async {
    return await GetStorage().read('user_login_key') ?? '';
  }
}
