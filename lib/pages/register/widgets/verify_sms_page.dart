import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/commons/utils/valid_utils.dart';
import 'package:tempapp/models/size_info_model.dart';
import 'package:tempapp/pages/register/register_controller.dart';

class VerifySmsPage extends StatelessWidget {
  final RegisterController controller;
  final SizeInfoModel sizeInfo;

  const VerifySmsPage({Key? key, required this.controller, required this.sizeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lbHeaderWidget(),
          txtCodeWidget(),
          btVerifyCodeWidget(),
          lbResendVerifyPhoneNumberWidget(),
        ],
      ),
    );
  }

  Widget lbHeaderWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Xác nhận mã OTP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: sizeInfo.fontSize)),
          SizedBox(height: 10),
          RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
            TextSpan(text: 'Mã số đã gửi tới số ', style: TextStyle(color: Colors.grey[800], fontSize: sizeInfo.fontSize)),
            TextSpan(text: '(+84)${controller.txtPhone.text}', style: TextStyle(fontWeight: FontWeight.w700)),
          ])),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget txtCodeWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller.txtCode,
        maxLines: 1,
        maxLength: 12,
        textInputAction: TextInputAction.done,
        autofocus: false,
        keyboardType: TextInputType.number,
        inputFormatters: [numberValidator],
        style: TextStyle(fontSize: sizeInfo.fontSize, color: Colors.blue[700]),
        decoration: InputDecoration(
          counterText: '',
          labelText: 'Mã số',
          prefixIcon: Icon(Icons.sms),
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

  Widget btVerifyCodeWidget() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red[400])),
          child: Container(
            width: sizeInfo.screenSize.width,
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            child: Obx(
              () => (controller.isVerifingCode.value)
                  ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Resource.str_otp_code,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: sizeInfo.fontSize),
                        ),
                        SizedBox(width: sizeInfo.screenSize.width * 0.02),
                        Icon(Icons.message, size: 19, color: Colors.white),
                      ],
                    ),
            ),
          ),
          onPressed: () => controller.verifyCode()),
    );
  }

  Widget lbResendVerifyPhoneNumberWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Chưa nhận mã OTP?', style: TextStyle(fontWeight: FontWeight.w500)),
          Obx(
            () => TextButton(
              onPressed: (controller.timeOut.value > 0)
                  ? null
                  : () {
                      controller.reVerifyPhoneNumber();
                    },
              child: (controller.isVerifingPhone.value)
                  ? SizedBox(width: 15, height: 15, child: CircularProgressIndicator())
                  : Text('Gửi lại (${controller.timeOut.value.toString().padLeft(2, '0')})s'),
            ),
          ),
        ],
      ),
    );
  }
}
