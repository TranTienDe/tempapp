import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tempapp/models/size_info_model.dart';
import 'package:tempapp/pages/dashboard/home/home_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  final HomeController controller;
  final SizeInfoModel sizeInfo;
  final bool limitY;

  const LineChartWidget(
      {Key? key,
      required this.controller,
      required this.sizeInfo,
      required this.limitY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      legend: Legend(isVisible: false),
      tooltipBehavior:
          TooltipBehavior(enable: true, textAlignment: ChartAlignment.near),
      primaryXAxis: DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        dateFormat: DateFormat.Hm(),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      primaryYAxis: this.limitY
          ? NumericAxis(
              minimum: 20,
              maximum: 45,
              labelFormat: '{value}°C',
              majorTickLines: const MajorTickLines(color: Colors.transparent),
            )
          : NumericAxis(
              labelFormat: '{value}°C',
              majorTickLines: const MajorTickLines(color: Colors.transparent),
            ),
      series: <ChartSeries<TempChartData, DateTime>>[
        LineSeries<TempChartData, DateTime>(
          onRendererCreated: (ChartSeriesController chartSeriesController) {
            controller.tempChartSeriesController = chartSeriesController;
          },
          name: 'Nhiệt độ',
          dataSource: controller.tempChartList,
          xValueMapper: (TempChartData temp, _) => temp.time,
          yValueMapper: (TempChartData temp, _) => temp.temp,
          pointColorMapper: (TempChartData temp, _) => temp.segmentColor,
          dataLabelSettings: DataLabelSettings(isVisible: false),
          enableTooltip: true,
          markerSettings: MarkerSettings(isVisible: false),
        ),
        LineSeries<TempChartData, DateTime>(
          onRendererCreated: (ChartSeriesController chartSeriesController) {
            controller.warningChartSeriesController = chartSeriesController;
          },
          name: 'Nhiệt độ cảnh báo',
          dataSource: controller.warningChartList,
          dashArray: <double>[5, 5],
          xValueMapper: (TempChartData temp, _) => temp.time,
          yValueMapper: (TempChartData temp, _) => temp.temp,
          dataLabelSettings: DataLabelSettings(isVisible: false),
          enableTooltip: false,
          markerSettings: MarkerSettings(isVisible: false),
        ),
      ],
    );
  }
}

class TempChartData {
  TempChartData(this.time, this.temp, this.segmentColor);
  final DateTime time;
  final double temp;
  final Color segmentColor;
}
