import 'package:flutter_blue/flutter_blue.dart';
import '../constants/Utility.dart' as Utility;

class BluetoothController {


  FlutterBlue _flutterBlue;

  BluetoothController() {
    /*this._flutterBlue = FlutterBlue.instance;*/
  }


  bool isBluetoothAvailable() {
    // this._flutterBlue.isAvailable;
    return true;
  }

  bool isBluetoothEnabled() {
    // this._flutterBlue.isOn;
    return true;
  }

  void searchForBeacons() {
    // this._flutterBlue.startScan(timeout: Duration(seconds: Utility.numSecondsForTimeoutBLE));

    // var subscription = this._flutterBlue.scanResults.listen(



    // this._flutterBlue.stopScan();
  }

}