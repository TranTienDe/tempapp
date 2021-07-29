import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/commons/routers/app_pages.dart';
import 'package:tempapp/commons/utils/valid_utils.dart';
import 'package:tempapp/commons/utils/widget_utils.dart';
import 'package:tempapp/pages/login/login_controller.dart';
import 'package:tempapp/models/size_info_model.dart';

class BodyWidget extends StatelessWidget {
  final LoginController controller;
  final SizeInfoModel sizeInfo;

  const BodyWidget({Key? key, required this.controller, required this.sizeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: sizeInfo.screenSize.width / 10.0,
          right: sizeInfo.screenSize.width / 10.0,
          top: sizeInfo.screenSize.height / 15.0),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lbWelcomeTextWidget(),
          textPhoneWidget(),
          textPasswordWidget(),
          lbForgotPasswordWidget(),
          btLoginWidget(),
          btRegisterWidget(),
          btCallWidget()
        ],
      )),
    );
  }

  Widget lbWelcomeTextWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        'Chào mừng đăng nhập!',
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blue[700],
            fontStyle: FontStyle.italic,
            fontSize: sizeInfo.fontSize),
      ),
    );
  }

  Widget textPhoneWidget() {
    return Container(
      child: TextField(
        focusNode: controller.phoneNode,
        controller: controller.txtPhone,
        maxLines: 1,
        maxLength: 12,
        textInputAction: TextInputAction.next,
        autofocus: false,
        keyboardType: TextInputType.number,
        inputFormatters: [numberValidator],
        style: TextStyle(fontSize: sizeInfo.fontSize, color: Colors.blue[700]),
        decoration: InputDecoration(
          counterText: '',
          labelText: 'Số điện thoại',
          prefixIcon:
              Icon(Icons.phone_android_rounded, color: Colors.blue[700]),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
      ),
    );
  }

  Widget textPasswordWidget() {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Obx(
            () => TextField(
              focusNode: controller.passwordNode,
              controller: controller.txtPassword,
              keyboardType: TextInputType.text,
              obscureText: !controller.showPass.value,
              maxLines: 1,
              maxLength: 100,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                  fontSize: sizeInfo.fontSize, color: Colors.blue[700]),
              decoration: InputDecoration(
                counterText: '',
                labelText: 'Mật khẩu',
                prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, right: 20),
          child: GestureDetector(
            onTap: () => controller.visiblePassWord(),
            child: Obx(
              () => controller.showPass.value
                  ? Icon(Icons.visibility_off, color: Colors.redAccent)
                  : Icon(Icons.visibility, color: Colors.blue[700]),
            ),
          ),
        ),
      ],
    );
  }

  Widget lbForgotPasswordWidget() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextButton(
            child: Text(
              'Quên mật khẩu?',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[700],
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
            ),
            onPressed: () => Get.toNamed(Paths.ForgotPassword),
          )
        ],
      ),
    );
  }

  Widget btLoginWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red[400])),
          child: Container(
            width: sizeInfo.screenSize.width,
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            child: Obx(
              () => (controller.isLoading.value)
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white))
                  : Text(
                      Resource.str_login,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: sizeInfo.fontSize),
                    ),
            ),
          ),
          onPressed: () => controller.login()),
    );
  }

  Widget btRegisterWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          child: Container(
            width: sizeInfo.screenSize.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  Resource.str_register,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: sizeInfo.fontSize),
                ),
              ],
            ),
          ),
          onPressed: () async {
            var phone = await Get.toNamed(Paths.Register);
            if (phone == null) return;
            controller.txtPhone.text = phone;
            showSnackBar('Thông báo', 'Tạo tài khoản thành công.');
          }),
    );
  }

  Widget btCallWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue)),
        child: Container(
          width: sizeInfo.screenSize.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.phone, size: 19, color: Colors.white),
              SizedBox(width: sizeInfo.screenSize.width * 0.02),
              Text(
                Resource.str_call_support,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: sizeInfo.fontSize),
              ),
            ],
          ),
        ),
        onPressed: () => controller.callPhone(),
      ),
    );
  }
}
