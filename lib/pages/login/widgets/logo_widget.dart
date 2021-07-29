import 'package:flutter/material.dart';
import 'package:tempapp/models/size_info_model.dart';

class LogoWidget extends StatelessWidget {
  final SizeInfoModel sizeInfo;
  const LogoWidget({Key? key, required this.sizeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeInfo.screenSize.width * 0.23,
      height: sizeInfo.screenSize.width * 0.23,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/logo_400.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
