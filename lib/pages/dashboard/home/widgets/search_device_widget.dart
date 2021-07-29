import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/constants/resource.dart';
import 'package:tempapp/models/size_info_model.dart';
import 'package:tempapp/pages/dashboard/home/home_controller.dart';

void showDeviceState(HomeController controller, SizeInfoModel sizeInfo) {
  Get.bottomSheet(
    Container(
      height: sizeInfo.screenSize.height * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Center(
        child: Column(
          children: [
            titleWidget(controller, sizeInfo),
            bodyWidget(sizeInfo),
          ],
        ),
      ),
    ),
    isDismissible: true,
  );

  if (!controller.hasDevice.value) {
    Future.delayed(Duration(seconds: 1), () {
      controller.isStartScan(true);
      controller.startScan(timeout: Duration(seconds: 4)).whenComplete(() => controller.isStartScan(false));
    });
  }
}

Widget titleWidget(HomeController controller, SizeInfoModel sizeInfo) {
  return Container(
    margin: EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(), primary: Colors.grey.shade400, padding: EdgeInsets.all(1)),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade400),
                child: Icon(Icons.close, color: Colors.grey.shade900),
              ),
              onPressed: () => Get.back(),
            ),
            Obx(
              () => Text('${controller.isStartScan.value ? 'Đang tìm thiết bị iTemp' : 'Danh sách thiết bị'}',
                  style: TextStyle(fontSize: sizeInfo.fontSize, fontWeight: FontWeight.bold)),
            ),
            StreamBuilder<bool>(
              stream: controller.isScanning,
              initialData: false,
              builder: (c, snapshot) {
                if (snapshot.data == true) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: CircleBorder(), primary: Colors.red.shade700),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red.shade700),
                          child: Icon(Icons.stop, color: Colors.white),
                        ),
                        CircularProgressIndicator()
                      ],
                    ),
                    onPressed: () => controller.stopScan(),
                  );
                } else {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: CircleBorder(), primary: Colors.blue.shade800),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.shade800),
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                    onPressed: () {
                      controller.isStartScan(true);
                      controller.hasDevice(false);
                      controller
                          .startScan(timeout: Duration(seconds: 4))
                          .whenComplete(() => controller.isStartScan(false));
                    },
                  );
                }
              },
            ),
          ],
        ),
        Divider(thickness: 1.0, color: Colors.black38),
      ],
    ),
  );
}

Widget bodyWidget(SizeInfoModel sizeInfo) {
  return SingleChildScrollView(
    child: Container(
      child: GetBuilder<HomeController>(
        builder: (controller) =>
            (controller.device != null) ? deviceStateTitle(controller, controller.device!) : findDevice(controller),
      ),
    ),
  );
}

Widget findDevice(HomeController controller) {
  return Container(
    child: StreamBuilder<List<ScanResult>>(
      stream: controller.scanResults,
      initialData: [],
      builder: (c, snapshot) => (snapshot.data != null)
          ? Column(
              children: snapshot.data!
                  .where((r) => r.device.name.toLowerCase().contains(Resource.bluetooth_device_name))
                  .map(
                    (r) => Container(
                      child: StreamBuilder<BluetoothDeviceState>(
                        initialData: BluetoothDeviceState.connected,
                        stream: r.device.state,
                        builder: (context, snapshot) {
                          if (snapshot.data == BluetoothDeviceState.connected)
                            return SizedBox(height: 0, child: Text(''));
                          else {
                            controller.hasDevice(true);
                            return deviceStateTitle(controller, r.device);
                          }
                        },
                      ),
                    ),
                  )
                  .toList(),
            )
          : Container(child: Center(child: SizedBox(height: 0, child: Text('')))),
    ),
  );
}

Widget deviceStateTitle(HomeController controller, BluetoothDevice device) {
  return ListTile(
    title: Text('${device.name}', style: TextStyle(color: Colors.blue.shade800)),
    subtitle: Text('${device.id.toString()}'),
    trailing: StreamBuilder<BluetoothDeviceState>(
      stream: device.state,
      initialData: BluetoothDeviceState.disconnected,
      builder: (c, snapshot) {
        VoidCallback? onPressed;
        String text = "";
        switch (snapshot.data) {
          case BluetoothDeviceState.connected:
            text = 'Ngắt kết nối';
            onPressed = () {
              controller.disConnect();
              Get.back();
            };
            break;
          case BluetoothDeviceState.disconnected:
            text = 'Kết nối';
            onPressed = () {
             controller.connect(device);
              Get.back();
            };
            break;
          default:
            onPressed = null;
            text = snapshot.data.toString().substring(21).toUpperCase();
            break;
        }
        return Obx(
          () => (controller.isDeviceState.value)
              ? Container(
                  margin: EdgeInsets.only(right: 15),
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(color: Colors.red.shade700))
              : ElevatedButton(onPressed: onPressed, child: Text(text)),
        );
      },
    ),
  );
}
