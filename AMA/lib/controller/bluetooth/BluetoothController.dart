import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'flutter_blue_beacon/beacon.dart';
import 'flutter_blue_beacon/flutter_blue_beacon.dart';

class BluetoothController {
  static BluetoothController _instance;
  Map<int, String> _locationMap = Map(); // maps an int to a string location

  static BluetoothController instance() {
    if (_instance == null) _instance = new BluetoothController();

    return _instance;
  }


  void fillLocationMap(List<String> locations) {
    for(int i = 0; i < locations.length; i++) {
      _locationMap.putIfAbsent(i, () => locations.elementAt(i));
    }
  }

  String getLocation(int id){

    return _locationMap[id];
  }


  Future<bool> isBluetoothAvailable() async {
    return await FlutterBlue.instance.isAvailable;
  }

  Future<bool> isBluetoothEnabled() async {
    return await FlutterBlue.instance.isOn;
  }

  Future<Set<int>> searchForBeacons() {
    FlutterBlueBeacon flutterBlueBeacon = FlutterBlueBeacon.instance;

    /// Scanning
    StreamSubscription _scanSubscription;
    Set<int> beacons = Set<int>();


    // Start scanning
    _scanSubscription = flutterBlueBeacon.scan(timeout: const Duration(seconds: 5)).listen((beacon) {

      if (beacon is EddystoneUID) {
        EddystoneUID b = beacon;
        // beacons[beacon.hash] = b;

        print("EddystoneUID");
        print("beaconId: ${b.beaconId}");
        print("namespaceId: ${b.namespaceId}");
        print("distance: ${b.distance}");
        beacons.add(int.parse(b.beaconId));
      }
    });

     return _scanSubscription.asFuture(beacons);
  }
}
