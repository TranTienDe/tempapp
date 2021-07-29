import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/utils/app_utils.dart';
import 'package:tempapp/commons/utils/widget_utils.dart';
import 'package:tempapp/services/google_auth_service.dart';
import 'package:tempapp/services/register_service.dart';

enum RegisterState { show_phone_state, show_verify_sms_state, show_password_state }

class RegisterController extends GetxController {
  var isVerifingPhone = false.obs;
  var isVerifingCode = false.obs;
  var isCreatingAccount = false.obs;
  var timeOut = 0.obs;
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var currState = RegisterState.show_phone_state.obs;

  //show_phone_state
  final phoneNode = FocusNode();
  final txtPhone = TextEditingController();

  //show_verify_sms_state
  final txtCode = TextEditingController();

  //show_password_state
  final fullNameNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();
  final txtFullName = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();

  String verifiedId = '';
  late Timer _timerTimeOut;
  String _phoneNumber = '';

  @override
  void onInit() {
    super.onInit();
    signOutPhone();
  }

  @override
  void onClose() {
    super.onClose();
    phoneNode.dispose();
    txtPhone.dispose();
    txtCode.dispose();
    fullNameNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();
    txtFullName.dispose();
    txtPassword.dispose();
    txtConfirmPassword.dispose();
  }

  void signOutPhone() async {
    await GoogleAuthService.instance.signOutPhone();
  }

  Future<void> checkExistPhone() async {
    if (txtPhone.text.isEmpty) throw 'Chưa nhập số điện thoại!';
    if (txtPhone.text.length < 10) throw 'Độ dài số điện thoại chưa hợp lệ!';
    phoneNode.unfocus();
    Map<String, dynamic> map = Map();
    map['fUserName'] = txtPhone.text;
    String json = jsonEncode(map);
    int res = await RegisterService.instanse.checkExistPhone(json);
    if (res > 0) throw 'Số điện thoại ${txtPhone.text} đã tồn tại.';
  }

  void verifyPhoneNumber() async {
    try {
      await checkExistPhone();
      isVerifingPhone(true);

      _phoneNumber = txtPhone.text;
      if (txtPhone.text.startsWith('0')) _phoneNumber = txtPhone.text.substring(1);
      if (!txtPhone.text.contains('+84')) _phoneNumber = '+84$_phoneNumber';

      await GoogleAuthService.instance.verifyPhoneNumber(
        phone: _phoneNumber,
        onCompleted: (phoneAuthCredential) {},
        onFailed: (ex) => showSnackBar('Error', ex.toString()),
        onSent: (verifiedId) {
          this.verifiedId = verifiedId;
          this.currState.value = RegisterState.show_verify_sms_state;

          timeOut.value = 45;
          _timerTimeOut = Timer.periodic(Duration(seconds: 1), (timer) {
            if (timeOut.value > 0) {
              timeOut.value--;
            } else {
              timeOut.value = 0;
              _timerTimeOut.cancel();
            }
          });
        },
        onTimeOut: (verifiedId) => this.verifiedId = verifiedId,
      );
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    } finally {
      isVerifingPhone(false);
    }
  }

  void reVerifyPhoneNumber() async {
    try {
      isVerifingPhone(true);
      await GoogleAuthService.instance.verifyPhoneNumber(
        phone: _phoneNumber,
        onCompleted: (phoneAuthCredential) {},
        onFailed: (ex) => showSnackBar('Error', ex.toString()),
        onSent: (verifiedId) {
          this.verifiedId = verifiedId;

          timeOut.value = 45;
          _timerTimeOut = Timer.periodic(Duration(seconds: 1), (timer) {
            if (timeOut.value > 0) {
              timeOut.value--;
            } else {
              timeOut.value = 0;
              _timerTimeOut.cancel();
            }
          });
        },
        onTimeOut: (verifiedId) => this.verifiedId = verifiedId,
      );
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    } finally {
      isVerifingPhone(false);
    }
  }

  void verifyCode() async {
    try {
      if (txtCode.text.length == 0) throw 'Chưa có mã otp.';
      if (txtCode.text.length < 6) throw 'Độ dài mã số chưa hợp lệ';
      isVerifingCode(true);
      User? user = await GoogleAuthService.instance.signInByPhone(verifiedId, txtCode.text);
      if (user != null)
        this.currState.value = RegisterState.show_password_state;
      else
        throw 'user is null or empty.';
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    } finally {
      isVerifingCode(false);
    }
  }

  void visiblePassWord() {
    showPassword.value = !showPassword.value;
  }

  void visibleConfirmPassWord() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void validBeforeCreateAccount() {
    fullNameNode.unfocus();
    passwordNode.unfocus();
    confirmPasswordNode.unfocus();

    if (txtFullName.text.length == 0) {
      fullNameNode.requestFocus();
      throw 'Chưa nhập họ và tên.';
    }

    if (txtPassword.text.length == 0) {
      passwordNode.requestFocus();
      throw 'Chưa nhập mật khẩu.';
    } else if (txtPassword.text.length < 6) {
      passwordNode.requestFocus();
      throw 'Mật khẩu phải từ 6 kí tự trở lên.';
    }

    if (txtConfirmPassword.text.length == 0) {
      confirmPasswordNode.requestFocus();
      throw 'Chưa nhập lại mật khẩu.';
    } else if (txtConfirmPassword.text.length < 6) {
      confirmPasswordNode.requestFocus();
      throw 'Mật khẩu phải từ 6 kí tự trở lên.';
    }

    if (txtPassword.text != txtConfirmPassword.text) {
      throw 'Mật khẩu chưa trùng khớp';
    }
  }

  void createAccount() async {
    try {
      validBeforeCreateAccount();
      isCreatingAccount(true);
      Map<String, dynamic> map = Map();
      map['fFullName'] = txtFullName.text;
      map['fPhone'] = txtPhone.text;
      map['fPassWord'] = AppUtils.generateMd5(txtPassword.text);
      String json = jsonEncode(map);
      int res = await RegisterService.instanse.signUpAccount(json);
      if (res >= 1) Get.back(result: txtPhone.text);
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    } finally {
      isCreatingAccount(false);
    }
  }
}
