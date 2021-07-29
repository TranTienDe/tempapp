import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/commons/routers/app_pages.dart';
import 'package:tempapp/commons/storages/user_storage.dart';
import 'package:tempapp/commons/utils/app_utils.dart';
import 'package:tempapp/commons/utils/valid_utils.dart';
import 'package:tempapp/commons/utils/widget_utils.dart';
import 'package:tempapp/models/user_model.dart';
import 'package:tempapp/services/login_service.dart';

class LoginController extends GetxController {
  var _service = LoginService();
  var showPass = false.obs;
  var isLoading = false.obs;

  final phoneNode = FocusNode();
  final passwordNode = FocusNode();
  final txtPhone = TextEditingController();
  final txtPassword = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getUserLocal();
  }

  @override
  void onClose() {
    super.onClose();
    phoneNode.dispose();
    passwordNode.dispose();
    txtPhone.dispose();
    txtPassword.dispose();
  }

  void visiblePassWord() {
    showPass.value = !showPass.value;
  }

  void callPhone() {
    try {
      AppUtils.callPhone(Resource.phone_number);
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    }
  }

  void getUserLocal() async {
    try {
      String data = await UserStorage.getUserLogin();
      if (data.length == 0) return;
      UserModel userModel = UserModel.fromJson(jsonDecode(data));
      txtPhone.text = userModel.fMobile ?? '';
      txtPassword.text = userModel.fPassword ?? '';
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    }
  }

  void accountValid(String phoneNumber, String password) {
    phoneNode.unfocus();
    passwordNode.unfocus();

    String errPhone = validateMobile(phoneNumber);
    if (errPhone.isNotEmpty) {
      phoneNode.requestFocus();
      throw errPhone;
    }

    String errPassword = validatePass(password);
    if (errPassword.isNotEmpty) {
      passwordNode.requestFocus();
      throw errPassword;
    }
  }

  void login() async {
    try {
      String phoneNumber = txtPhone.text;
      String password = txtPassword.text;
      accountValid(phoneNumber, password);

      isLoading(true);
      Map<String, dynamic> map = Map();
      map["fUserName"] = phoneNumber;
      map["fPassWord"] = AppUtils.generateMd5(password);

      String json = jsonEncode(map);
      var userModel = await _service.getUserLogin(json: json);
      userModel.fPassword = password;

      await UserStorage.saveLoginState(true);
      await UserStorage.saveUserLogin(jsonEncode(userModel));

      Get.offAllNamed(Paths.Dashboard);
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    } finally {
      isLoading(false);
    }
  }
}
