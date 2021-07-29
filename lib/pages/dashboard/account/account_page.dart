import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempapp/pages/dashboard/account/account_controller.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Tài khoản'),
      ),
    );
  }
}
