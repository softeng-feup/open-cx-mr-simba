import 'package:flutter_blue/flutter_blue.dart';
import '../../constants/Utility.dart' as Utility;

class BluetoothController {
  static BluetoothController _instance;

  static BluetoothController instance() {
    if (_instance == null) _instance = new BluetoothController();

    return _instance;
  }

  // TODO: FlutterBlue.instance nao retorna quando nao ha BT... ver melhor

  Future<bool> isBluetoothAvailable() async {
    return await FlutterBlue.instance.isAvailable;
  }

  Future<bool> isBluetoothEnabled() async {
    return await FlutterBlue.instance.isOn;
  }

  void searchForBeacons() {
    // Start scanning
    FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
    var scannedDevices;
    var subscription = FlutterBlue.instance.scanResults.listen((scannedDevices) {

      for(int i = 0; i < scannedDevices.length;i++){
        // do something with scan result
        var currentDevice = scannedDevices.elementAt(i).device; // found usefulness
        var currentAdvertisementData = scannedDevices.elementAt(i).advertisementData; 

        // print('${device.id} found! rssi: ${scannedDevices.elementAt(i).rssi} uuid: ${scannedDevices.elementAt(i).advertisementData.serviceUuids.elementAt(0)}');
      }
      
    });

// Stop scanning
    FlutterBlue.instance.stopScan();

    // this._flutterBlue.startScan(timeout: Duration(seconds: Utility.numSecondsForTimeoutBLE));
  }
}
