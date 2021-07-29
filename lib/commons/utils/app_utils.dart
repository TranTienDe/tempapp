import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';

class ResponsiveWidget {
  bool isScreenLarge(double width, double pixel) {
    return width * pixel >= 1440;
  }

  bool isScreenMedium(double width, double pixel) {
    return width * pixel < 1440 && width * pixel >= 1080;
  }

  bool isScreenSmall(double width, double pixel) {
    return width * pixel <= 720;
  }
}

class AppUtils {
  static double getFontSize(double width, double ratio) {
    var responsive = ResponsiveWidget();
    var screenLarge = responsive.isScreenLarge(width, ratio);
    var screenMedium = responsive.isScreenMedium(width, ratio);
    double fontSize = screenLarge ? 18 : (screenMedium ? 16 : 14);
    return fontSize;
  }

  static generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static launchURL(String url) async {
    if (url.isEmpty) throw 'Chưa có url!';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static callPhone(String number) {
    if (number.isEmpty) throw 'Chưa có số điện thoại!';
    launch('tel:$number');
  }

  static sendMail(String mailAddress) {
    if (mailAddress.isEmpty) throw 'Chưa có email!';
    launch('mailto:$mailAddress');
  }
}
