import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tempapp/models/size_info_model.dart';

class ProgressBarStyle extends StatefulWidget {
  final SizeInfoModel sizeInfo;

  const ProgressBarStyle({Key? key, required this.sizeInfo}) : super(key: key);

  @override
  _ProgressBarStyleState createState() => _ProgressBarStyleState();
}

class _ProgressBarStyleState extends State<ProgressBarStyle> {
  double progressValue = 0;
  double _size = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer _timer) {
        setState(() {
          if (progressValue == 100) {
            progressValue = 0;
          } else {
            progressValue++;
          }
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _size = widget.sizeInfo.screenSize.width * 0.5;
    return Center(child: getSementedProgressBar());
  }

  Widget getSementedProgressBar() {
    return Container(
        width: _size,
        height: _size,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              showTicks: false,
              showLabels: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.85,
              axisLineStyle: const AxisLineStyle(thickness: 30, dashArray: <double>[15, 2]),
              pointers: <GaugePointer>[
                RangePointer(
                    value: progressValue,
                    width: 30,
                    enableAnimation: true,
                    animationDuration: 30,
                    gradient: const SweepGradient(colors: <Color>[
                      Color.fromRGBO(255, 4, 0, 1),
                      Color.fromRGBO(255, 15, 0, 1),
                      Color.fromRGBO(255, 31, 0, 1),
                      Color.fromRGBO(255, 60, 0, 1),
                      Color.fromRGBO(255, 90, 0, 1),
                      Color.fromRGBO(255, 115, 0, 1),
                      Color.fromRGBO(255, 135, 0, 1),
                      Color.fromRGBO(255, 155, 0, 1),
                      Color.fromRGBO(255, 175, 0, 1),
                      Color.fromRGBO(255, 188, 0, 1),
                      Color.fromRGBO(255, 188, 0, 1),
                      Color.fromRGBO(251, 188, 2, 1),
                      Color.fromRGBO(245, 188, 6, 1),
                      Color.fromRGBO(233, 188, 12, 1),
                      Color.fromRGBO(220, 187, 19, 1),
                      Color.fromRGBO(208, 187, 26, 1),
                      Color.fromRGBO(193, 187, 34, 1),
                      Color.fromRGBO(177, 186, 43, 1),
                    ], stops: <double>[
                      0.05,
                      0.1,
                      0.15,
                      0.2,
                      0.25,
                      0.3,
                      0.35,
                      0.4,
                      0.45,
                      0.5,
                      0.55,
                      0.6,
                      0.65,
                      0.7,
                      0.75,
                      0.8,
                      0.85,
                      0.9,
                    ]),
                    dashArray: const <double>[15, 2])
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.25,
                    widget: Container(
                        // added text widget as an annotation.
                        child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Xin chờ',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Times',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                          Text(progressValue.toStringAsFixed(0) + '%',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Times',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ],
                      ),
                    )))
              ],
            ),
          ],
        ));
  }
}
