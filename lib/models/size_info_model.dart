import 'package:flutter/cupertino.dart';

class SizeInfoModel {
  final Orientation orientation;
  final Size screenSize;
  final double ratio;
  final double fontSize;

  SizeInfoModel(
      {required this.orientation,
      required this.screenSize,
      required this.ratio,
      required this.fontSize});

  @override
  String toString() {
    return 'orientation: $orientation screenSize:$screenSize ratio:$ratio fontSize:$fontSize';
  }
}
