import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/models/size_info_model.dart';
import 'package:tempapp/pages/register/register_controller.dart';

class VerifyPasswordPage extends StatelessWidget {
  final RegisterController controller;
  final SizeInfoModel sizeInfo;

  const VerifyPasswordPage({Key? key, required this.controller, required this.sizeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textPhoneWidget(),
          textFullNameWidget(),
          textPasswordWidget(),
          textConfirmPasswordWidget(),
          btCreateAccountWidget(),
        ],
      ),
    );
  }

  Widget textPhoneWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        controller: controller.txtPhone,
        maxLines: 1,
        maxLength: 200,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        autofocus: false,
        enabled: false,
        style: TextStyle(fontSize: sizeInfo.fontSize, color: Colors.blue[700]),
        decoration: InputDecoration(
          counterText: '',
          labelText: 'Số điện thoại',
          prefixIcon: Icon(Icons.phone_android),
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

  Widget textFullNameWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        focusNode: controller.fullNameNode,
        controller: controller.txtFullName,
        maxLines: 1,
        maxLength: 200,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        autofocus: false,
        style: TextStyle(fontSize: sizeInfo.fontSize, color: Colors.blue[700]),
        decoration: InputDecoration(
          counterText: '',
          labelText: 'Họ và tên',
          prefixIcon: Icon(Icons.account_circle),
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
              obscureText: !controller.showPassword.value,
              maxLines: 1,
              maxLength: 100,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                  fontSize: sizeInfo.fontSize, color: Colors.blue.shade700),
              decoration: InputDecoration(
                counterText: '',
                labelText: 'Mật khẩu',
                prefixIcon: Icon(Icons.lock, color: Colors.blue.shade700),
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
                  () => controller.showPassword.value
                  ? Icon(Icons.visibility_off, color: Colors.redAccent)
                  : Icon(Icons.visibility, color: Colors.blue.shade700),
            ),
          ),
        ),
      ],
    );
  }

  Widget textConfirmPasswordWidget() {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Obx(
                () => TextField(
              focusNode: controller.confirmPasswordNode,
              controller: controller.txtConfirmPassword,
              keyboardType: TextInputType.text,
              obscureText: !controller.showConfirmPassword.value,
              maxLines: 1,
              maxLength: 100,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                  fontSize: sizeInfo.fontSize, color: Colors.blue.shade700),
              decoration: InputDecoration(
                counterText: '',
                labelText: 'Nhập lại mật khẩu',
                prefixIcon: Icon(Icons.lock, color: Colors.blue.shade700),
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
            onTap: () => controller.visibleConfirmPassWord(),
            child: Obx(
                  () => controller.showConfirmPassword.value
                  ? Icon(Icons.visibility_off, color: Colors.redAccent)
                  : Icon(Icons.visibility, color: Colors.blue.shade700),
            ),
          ),
        ),
      ],
    );
  }

  Widget btCreateAccountWidget() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red[400])),
          child: Container(
            width: sizeInfo.screenSize.width,
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            child: Obx(
                  () => (controller.isCreatingAccount.value)
                  ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white))
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tạo tài khoản',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: sizeInfo.fontSize),
                  ),
                ],
              ),
            ),
          ),
          onPressed: () => controller.createAccount()),
    );
  }

}
