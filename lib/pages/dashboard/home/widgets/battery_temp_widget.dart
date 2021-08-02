import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/commons/utils/widget_utils.dart';
import 'package:tempapp/commons/widgets/confirm_dialog.dart';
import 'package:tempapp/models/size_info_model.dart';
import 'package:tempapp/pages/dashboard/home/home_controller.dart';
import 'package:tempapp/pages/dashboard/home/widgets/pin_widget/battery_level_painter_widget.dart';
import 'package:tempapp/pages/dashboard/home/widgets/progressbar_widget/semented_progressbar_widget.dart';
import 'package:tempapp/pages/dashboard/home/widgets/search_device_widget.dart';

class BatteryTempWidget extends StatelessWidget {
  final HomeController controller;
  final SizeInfoModel sizeInfo;

  const BatteryTempWidget({Key? key, required this.controller, required this.sizeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          batteryAndCurrentTempTop(context),
          deviceGifAndTempBottom(),
        ],
      ),
    );
  }

  //Hiển thị phần trăm pin và lấy nhiệt độ hiện tại
  Widget batteryAndCurrentTempTop(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50.0,
            height: 20.0,
            child: CustomPaint(
              painter: BatteryLevelPainterWidget(batteryLevel: 50),
              child: Center(child: Text('50%', style: TextStyle(color: Colors.black54))),
            ),
          ),
          InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Obx(() => Text('${controller.deviceName.value}',
                      style: TextStyle(
                          color: Colors.grey.shade800, fontSize: sizeInfo.fontSize, fontWeight: FontWeight.w500))),
                ),
                Icon(Icons.autorenew, color: Colors.blue, size: 28),
              ],
            ),
            onTap: () {
              String content = "Nhiệt độ hiện tại đang là: ${controller.currentTemp.toString()} °C";
              ConfirmDialog.showButtonPress(context, true, '', content, 'Đóng', () => Navigator.of(context).pop());
            },
          )
        ],
      ),
    );
  }

  //Hiện thị file gif và nhiệt độ theo dõi
  Widget deviceGifAndTempBottom() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (controller.device == null) {
          printText('--->call deviceGifAndButtonConnectWidget.');
          return deviceGifAndButtonConnectWidget();
        } else {
          printText('--->call getServiceWidget.');
          return getServiceWidget();
        }
      },
    );
  }

  //Hiện thị file gif và nút kết nối
  Widget deviceGifAndButtonConnectWidget() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              color: Colors.white,
              child: Image.asset('assets/gifs/device_transparent.gif',
                  height: sizeInfo.screenSize.height * 0.2, fit: BoxFit.contain),
            ),
            onTap: () => showDeviceState(controller, sizeInfo),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                primary: Colors.grey.shade100,
                elevation: 0.2,
              ),
              child: Container(
                width: sizeInfo.screenSize.width * 0.35,
                alignment: Alignment.center,
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: sizeInfo.fontSize * 0.8),
                ),
              ),
              onPressed: () => showDeviceState(controller, sizeInfo),
            ),
          )
        ],
      ),
    );
  }

  //Tìm kiếm services
  Widget getServiceWidget() {
    return Column(
      children: [
        StreamBuilder<BluetoothDeviceState>(
          stream: controller.device!.state,
          initialData: BluetoothDeviceState.connecting,
          builder: (c, snapshot) {
            if (snapshot.data == BluetoothDeviceState.connected) {
              printText('--->call connected.');
              controller.isDeviceConnecting(false);
              controller.device!.discoverServices();
              return StreamBuilder<List<BluetoothService>>(
                  stream: controller.device!.services,
                  initialData: [],
                  builder: (c, snapshot) {
                    if (snapshot.data!.length > 0) {
                      return getCharacterWidget(snapshot.data!);
                    } else {
                      return showNoneTempWatchWidget(0);
                    }
                  });
            } else if (snapshot.data == BluetoothDeviceState.connecting) {
              printText('--->call connecting.');
              return Container(child: Center(child: Text('Đang kết nối!')));
            } else {
              return Obx(() {
                if (controller.isDeviceConnecting.value) {
                  printText('--->call isDeviceConnecting = true.');
                  return InkWell(
                    child: ProgressBarStyle(sizeInfo: sizeInfo),
                    onTap: () => showDeviceState(controller, sizeInfo),
                  );
                } else {
                  printText('--->call isDeviceConnecting = false.');
                  if (controller.device != null) {
                    Future.delayed(Duration(seconds: 1), () {
                      printText('--->call disConnected.');
                      controller.disConnect();
                    }); // use await builder
                  }
                  return deviceGifAndButtonConnectWidget();
                }
              });
            }
          },
        ),
      ],
    );
  }

  //Lấy thông tin character
  Widget getCharacterWidget(List<BluetoothService> services) {
    var character = services
        .singleWhere((s) => s.uuid.toString() == Resource.UUID_TEMPERATURE_SERVICE)
        .characteristics
        .singleWhere((c) => c.uuid.toString() == Resource.UUID_TEMPERATURE_CHARACTERISTIC);

    bool isNotify = character.isNotifying;
    if (Platform.isAndroid) {
      if (!isNotify) character.setNotifyValue(true);
    } else if (Platform.isIOS) character.setNotifyValue(true);

    return StreamBuilder<List<int>>(
      stream: character.value,
      initialData: character.lastValue,
      builder: (c, snapshot) {
        final value = (snapshot.data != null && snapshot.data!.length > 0)
            ? controller.getTempDataThermometer(snapshot.data!)
            : 0.0;
        controller.currentTemp = value;
        String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
        printText('date: $date - Value: $value');
        return showTempWatchWidget(value);
      },
    );
  }

  //Hiện thị nhiệt độ theo dõi
  Widget showTempWatchWidget(double tempValue) {
    return InkWell(
      onTap: () => showDeviceState(controller, sizeInfo),
      child: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: sizeInfo.screenSize.width * 0.7,
                height: sizeInfo.screenSize.height * 0.3,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(minimum: 20, maximum: 40, minorTicksPerInterval: 10, ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 20,
                        endValue: 40,
                        startWidth: 11.5,
                        endWidth: 11.5,
                        gradient: SweepGradient(
                          stops: <double>[0.3, 0.8, 0.9],
                          colors: <Color>[Colors.green, Colors.yellow, Colors.red],
                        ),
                      ),
                    ], pointers: <GaugePointer>[
                      NeedlePointer(
                        value: tempValue,
                        needleColor: Colors.grey.shade800,
                        tailStyle: TailStyle(
                            length: 0.25, width: 5, color: Colors.grey.shade800, lengthUnit: GaugeSizeUnit.factor),
                        needleLength: sizeInfo.screenSize.width * 0.00153,
                        needleStartWidth: 1,
                        needleEndWidth: 5,
                        knobStyle: KnobStyle(
                            knobRadius: 0.07,
                            color: Colors.white,
                            borderWidth: 0.05,
                            borderColor: Colors.grey.shade800),
                        lengthUnit: GaugeSizeUnit.factor,
                        enableAnimation: true,
                      ),
                      MarkerPointer(
                        value: 35.5,
                        elevation: 4,
                        markerWidth: 23,
                        markerHeight: 26,
                        color: const Color(0xFFF67280),
                        markerType: MarkerType.invertedTriangle,
                        markerOffset: -12,
                        enableAnimation: true,
                        enableDragging: true,
                      ),
                    ], annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$tempValue',
                                  style: TextStyle(
                                      color: tempValue > Resource.temperature_limit ? Colors.red : Colors.blue,
                                      fontSize: sizeInfo.fontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('°C', style: TextStyle(fontWeight: FontWeight.w500))],
                                )
                              ],
                            ),
                          ),
                          positionFactor: 0.8,
                          angle: 90),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Hiện thị nhiệt độ none
  Widget showNoneTempWatchWidget(double tempValue) {
    return InkWell(
      onTap: () => showDeviceState(controller, sizeInfo),
      child: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: sizeInfo.screenSize.width * 0.7,
                height: sizeInfo.screenSize.height * 0.3,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(minimum: 20, maximum: 40, minorTicksPerInterval: 10, ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 20,
                        endValue: 40,
                        startWidth: 11.5,
                        endWidth: 11.5,
                        gradient: SweepGradient(
                          stops: <double>[0.3, 0.8, 0.9],
                          colors: <Color>[Colors.green, Colors.yellow, Colors.red],
                        ),
                      ),
                    ], pointers: <GaugePointer>[
                      NeedlePointer(
                        value: tempValue,
                        needleColor: Colors.grey.shade800,
                        tailStyle: TailStyle(
                            length: 0.25, width: 5, color: Colors.grey.shade800, lengthUnit: GaugeSizeUnit.factor),
                        needleLength: sizeInfo.screenSize.width * 0.00153,
                        needleStartWidth: 1,
                        needleEndWidth: 5,
                        knobStyle: KnobStyle(
                            knobRadius: 0.07,
                            color: Colors.white,
                            borderWidth: 0.05,
                            borderColor: Colors.grey.shade800),
                        lengthUnit: GaugeSizeUnit.factor,
                        enableAnimation: true,
                      ),
                      /*  MarkerPointer(
                        value: 35.5,
                        elevation: 4,
                        markerWidth: 23,
                        markerHeight: 26,
                        color: const Color(0xFFF67280),
                        markerType: MarkerType.invertedTriangle,
                        markerOffset: -12,
                        enableAnimation: true,
                        enableDragging: true,
                      ),*/
                    ], annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$tempValue',
                                    style: TextStyle(
                                        color: tempValue > Resource.temperature_limit ? Colors.red : Colors.blue,
                                        fontSize: sizeInfo.fontSize,
                                        fontWeight: FontWeight.bold)),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('°C', style: TextStyle(fontWeight: FontWeight.w500))],
                                )
                              ],
                            ),
                          ),
                          positionFactor: 0.8,
                          angle: 90),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
