import 'package:flutter_blue/flutter_blue.dart';
import '../../constants/Utility.dart' as Utility;

class BluetoothController {

  static BluetoothController _instance;
  FlutterBlue _flutterBlue;
  bool _isAvailable;
  bool _isEnabled;

  BluetoothController() {
    this._flutterBlue = FlutterBlue.instance;
  }

  static BluetoothController instance() {
    if(_instance == null)
        _instance = new BluetoothController();

    return _instance;
  }



  Future _checkBTAvailable() async {
    final aux = await _flutterBlue.isAvailable;
    if(aux)
      _isAvailable = true;
    else
      _isAvailable = false;
  }

  bool isBluetoothAvailable() {
    _checkBTAvailable(); // e async, logo quando retorna _isAvailable ainda nao e false/true, ainda e null
    return _isAvailable;
  }


  Future _checkBTEnabled() async {
    final aux = await _flutterBlue.isOn;
    if(aux)
      _isEnabled = true;
    else
      _isEnabled = false;
  }

  bool isBluetoothEnabled() {
    _checkBTEnabled();
    return _isEnabled;
  }


  void searchForBeacons() {

    if(!isBluetoothAvailable() || !isBluetoothEnabled())
      return;

    this._flutterBlue.startScan(timeout: Duration(seconds: Utility.numSecondsForTimeoutBLE));


  }

}