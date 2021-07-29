import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/utils/widget_utils.dart';
import 'package:tempapp/services/blue_service.dart';

class HomeController extends GetxController {
  var isStartScan = false.obs; //Thay đổi text title trên bottomsheet

  var hasDevice = false.obs; //Kiểm tra nếu chưa có danh sách thiết bị

  var isDeviceStating = false.obs; //Báo thay đổi trang thái kết nối trên bottomsheet

  var isDeviceConnecting = false.obs; //Trạng thái đang kết nối

  var deviceName = ''.obs;

  BluetoothDevice? device;

  BluetoothDeviceState updateDeviceState = BluetoothDeviceState.disconnected;
  BluetoothDeviceState currentDeviceState = BluetoothDeviceState.disconnected;

  Stream<BluetoothState> get state => BlueService.instance.state;

  Stream<bool> get isScanning => BlueService.instance.isScanning;

  Stream<List<ScanResult>> get scanResults => BlueService.instance.scanResults;

  Future startScan({Duration? timeout}) => BlueService.instance.startScan(timeout: timeout);

  Future stopScan() => BlueService.instance.stopScan();

  Timer? deviceStateTimer;

  @override
  void onInit() {
    super.onInit();
    //onDeviceStateListener();
  }

  @override
  void onClose() {
    super.onClose();
    //deviceStateTimer?.cancel();
  }

  void onDeviceStateListener() {
    deviceStateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      //print('updateDeviceState: $updateDeviceState');
      if (updateDeviceState == currentDeviceState) return;

      switch (updateDeviceState) {
        case BluetoothDeviceState.connected:
          currentDeviceState = updateDeviceState;
          showSnackBar('Đã kết nối thiết bị', 'Thiết bị đang trong quá trình kết nối !');
          break;
        case BluetoothDeviceState.disconnected:
          currentDeviceState = updateDeviceState;
          showSnackBar('Đã ngắt kết nối thiết bị', '');
          break;
      }
    });
  }

  void connect(BluetoothDevice device) {
    try {
      this.isDeviceStating(true);
      this.isDeviceConnecting(true);
      device.connect(autoConnect: false).timeout(Duration(seconds: 30), onTimeout: () {
        printText('--->call device connect timeout.');
        this.isDeviceConnecting(false);
      });
      this.device = device;
      this.deviceName(this.device!.name);
      update();
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    } finally {
      this.isDeviceStating(false);
    }
  }

  void disConnect() async {
    try {
      if ( this.device == null) throw 'Device is null!';
      this.isDeviceStating(true);
      this.device!.disconnect();
      this.device = null;
      this.deviceName('');
      update();
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    } finally {
      this.isDeviceStating(false);
    }
  }

  double getTempDataThermometer(List<int> list) {
    double dTemp = 0;
    try {
      var value = [list[1], list[2], list[3], 0];
      var intValue = int.parse(
          '${((value[3] << 24) & -16777216) | (value[0] & 255) | ((value[1] << 8) & 65280) | ((value[2] << 16) & 16711680)}');
      double doubleValue = intValue * 0.01;
      String tempFixed = doubleValue.toStringAsFixed(2);
      dTemp = double.parse(tempFixed);
    } catch (ex) {
      print('---> Error: ${ex.toString()}');
    }
    return dTemp;
  }
}
