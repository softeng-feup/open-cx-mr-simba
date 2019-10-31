import 'package:flutter_blue/flutter_blue.dart';
import '../../constants/Utility.dart' as Utility;

class BluetoothController {

  static BluetoothController _instance;

  static BluetoothController instance() {
    if(_instance == null)
        _instance = new BluetoothController();

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

    // this._flutterBlue.startScan(timeout: Duration(seconds: Utility.numSecondsForTimeoutBLE));


  }

}