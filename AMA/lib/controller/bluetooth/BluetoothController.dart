import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import '../../constants/Utility.dart' as Utility;
import 'flutter_blue_beacon/beacon.dart';
import 'flutter_blue_beacon/flutter_blue_beacon.dart';

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
    FlutterBlueBeacon flutterBlueBeacon = FlutterBlueBeacon.instance;
    FlutterBlue _flutterBlue = FlutterBlue.instance;

    /// Scanning
    StreamSubscription _scanSubscription;
    Map<int, EddystoneUID> beacons = new Map();
    bool isScanning = false;

    // Start scanning

    _scanSubscription = flutterBlueBeacon
        .scan(timeout: const Duration(seconds: 5))
        .listen((beacon) {
      print('localName: ${beacon.scanResult.advertisementData.localName}');
      print(
          'manufacturerData: ${beacon.scanResult.advertisementData.manufacturerData}');
      print('serviceData: ${beacon.scanResult.advertisementData.serviceData}');
      

      if(beacon is EddystoneUID){

        EddystoneUID b = beacon;
        beacons[beacon.hash] = b;

        print("EddystoneUID");
        print("beaconId: ${b.beaconId}");
        print("namespaceId: ${b.namespaceId}");
        print("tx: ${b.tx}");
        print("rssi: ${b.rssi}");
        print("distance: ${b.distance}");
      }

    });
  }
}
