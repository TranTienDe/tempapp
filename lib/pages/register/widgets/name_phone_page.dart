import 'package:flutter/material.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/commons/utils/valid_utils.dart';
import 'package:tempapp/pages/register/register_controller.dart';
import 'package:tempapp/models/size_info_model.dart';

class NamePhonePage extends StatelessWidget {
  final RegisterController controller;
  final SizeInfoModel sizeInfo;

  const NamePhonePage({Key? key, required this.controller, required this.sizeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lbHeaderWidget(),
          textPhoneWidget(),
          btReceiveOTPCodeWidget(),
        ],
      ),
    );
  }

  Widget lbHeaderWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Nhập số điện thoại của bạn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: sizeInfo.fontSize)),
          SizedBox(height: 10),
          Text(
            'Chúng tôi sẽ gửi mã OTP tới số điện thoại này.',
            style: TextStyle(fontSize: sizeInfo.fontSize),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget textPhoneWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        focusNode: controller.phoneNode,
        controller: controller.txtPhone,
        maxLines: 1,
        maxLength: 12,
        textInputAction: TextInputAction.done,
        autofocus: false,
        keyboardType: TextInputType.number,
        inputFormatters: [numberValidator],
        style: TextStyle(fontSize: sizeInfo.fontSize, color: Colors.blue[700]),
        decoration: InputDecoration(
          counterText: '',
          labelText: 'Số điện thoại',
          prefixIcon: Padding(padding: EdgeInsets.all(10), child: Text('+84')),
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
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

  Widget btReceiveOTPCodeWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red.shade400)),
          child: Container(
            width: sizeInfo.screenSize.width,
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            child: Row(
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
          onPressed: () => controller.verifyPhoneNumber()),
    );
  }
}
