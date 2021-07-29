import 'package:flutter_blue/flutter_blue.dart';

class BlueService {
  BlueService._privateConstructor();

  static final BlueService instance = BlueService._privateConstructor();

  final _blue = FlutterBlue.instance;

  Stream<BluetoothState> get state => _blue.state;
  Stream<bool> get isScanning => _blue.isScanning;
  Stream<List<ScanResult>> get scanResults => _blue.scanResults;

  Future stopScan() => _blue.stopScan();
  Future startScan({Duration? timeout}) => _blue.startScan(timeout: timeout);


}
