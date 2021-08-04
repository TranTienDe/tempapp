import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/pages/base_page.dart';
import 'package:tempapp/pages/dashboard/home/home_controller.dart';
import 'package:tempapp/pages/dashboard/home/widgets/charts/line_chart_widget.dart';

class ChartPage extends StatelessWidget {
  final HomeController controller;
  const ChartPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return BasePage(builder: (context, sizeInfo) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Biểu đồ nhiệt độ'),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Container(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    icon: const Icon(Icons.info_outline, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12), bottom: Radius.circular(0)),
              color: Resource.cardThemeColor,
            ),
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: LineChartWidget(
              controller: controller,
              sizeInfo: sizeInfo,
              limitY: false,
            ),
          ),
        ),
      );
    });
  }
}
