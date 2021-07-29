import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:tempapp/commons/utils/widget_utils.dart';
import 'package:tempapp/services/blue_service.dart';

class HomeController extends GetxController {
  ///Thay đổi text title trên bottomsheet
  var isStartScan = false.obs;

  ///Kiểm tra nếu chưa có danh sách thiết bị
  var hasDevice = false.obs;

  ///Báo thay đổi trang thái kết nối trên bottomsheet
  var isDeviceState = false.obs;

  //Trạng thái đang kết nối
  var isDeviceConnecting = false.obs;

  ///Tên của thiết bị
  var deviceName = ''.obs;

  ///Device iTemp
  BluetoothDevice? device;

  Stream<BluetoothState> get state => BlueService.instance.state;

  Stream<bool> get isScanning => BlueService.instance.isScanning;

  Stream<List<ScanResult>> get scanResults => BlueService.instance.scanResults;

  Future startScan({Duration? timeout}) => BlueService.instance.startScan(timeout: timeout);

  Future stopScan() => BlueService.instance.stopScan();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void connect(BluetoothDevice device) {
    try {
      isDeviceState(true);
      isDeviceConnecting(true);
      device.connect(autoConnect: false).timeout(Duration(seconds: 30), onTimeout: () {
        device.disconnect();
        isDeviceConnecting(false);
      });
      this.device = device;
      deviceName(this.device!.name);
      update();
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    } finally {
      isDeviceState(false);
    }
  }

  void disConnect() {
    try {
      if (device == null) throw 'Device is null!';
      isDeviceState(true);
      device!.disconnect();
      device = null;
      deviceName('');
      update();
    } catch (ex) {
      showSnackBar('Error', ex.toString());
    } finally {
      isDeviceState(false);
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
