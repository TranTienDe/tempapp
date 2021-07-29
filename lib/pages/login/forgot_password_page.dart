import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/commons/utils/app_utils.dart';
import 'package:tempapp/pages/base_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(builder: (context, sizeInfo) {
      return Scaffold(
        appBar: AppBar(title: Text(Resource.str_forgot_password), centerTitle: true),
        body: Container(
          margin: EdgeInsets.only(
            left: sizeInfo.screenSize.width / 10.0,
            right: sizeInfo.screenSize.width / 10.0,
            top: sizeInfo.screenSize.height / 15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                Resource.str_forgot_password_title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: sizeInfo.fontSize,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
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
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: sizeInfo.fontSize),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => AppUtils.callPhone(Resource.phone_number),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
