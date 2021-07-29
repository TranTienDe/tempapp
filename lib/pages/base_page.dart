import 'package:flutter/material.dart';
import 'package:tempapp/commons/utils/app_utils.dart';
import 'package:tempapp/models/size_info_model.dart';

class BasePage extends StatelessWidget {
  final Widget Function(BuildContext context, SizeInfoModel sizeInfoModel)
      builder;
  const BasePage({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var fontSize = AppUtils.getFontSize(
        mediaQuery.size.width, mediaQuery.devicePixelRatio);

    return LayoutBuilder(
      builder: (context, boxConstraints) {
        var sizeInfoModel = SizeInfoModel(
            orientation: mediaQuery.orientation,
            screenSize: mediaQuery.size,
            ratio: mediaQuery.devicePixelRatio,
            fontSize: fontSize);

        return builder(context, sizeInfoModel);
      },
    );
  }
}
