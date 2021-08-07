import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/pages/base_page.dart';
import 'package:tempapp/pages/dashboard/home/home_controller.dart';
import 'package:tempapp/pages/dashboard/home/widgets/charts/line_chart_full_widget.dart';

class ChartPage extends StatelessWidget {
  final HomeController controller;

  const ChartPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(builder: (context, sizeInfo) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Biểu đồ nhiệt độ'),
                Container(
                  child: Row(
                    children: [
                      Image.asset('assets/images/temperature_indicator_light.png',
                          fit: BoxFit.contain, height: 20, width: 20),
                      StreamBuilder<double>(
                        stream: controller.tempRealTimeResult,
                        initialData: controller.currentTemp,
                        builder: (context, snapshot) {
                          return Text('${snapshot.data}°C');
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Hero(
            tag: 'chartTag',
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12), bottom: Radius.circular(0)),
                color: Resource.cardThemeColor,
              ),
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: LineChartFullWidget(
                controller: controller,
                sizeInfo: sizeInfo,
                limitY: true,
              ),
            ),
          ),
        ),
      );
    });
  }
}
