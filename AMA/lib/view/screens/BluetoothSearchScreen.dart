import 'dart:collection';

import 'package:ama/controller/Controller.dart';
import 'package:ama/controller/bluetooth/BluetoothController.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:ama/view/components/SessionContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class BluetoothSearchScreen extends StatefulWidget {
  bool availabilityStatus = true;
  bool enabledStatus = true;
  bool scanVisible = true;
  bool scanEnabled = true;
  List<Session> nearbySessions = List<Session>();
  @override
  BluetoothSearchScreenState createState() => BluetoothSearchScreenState();
}

class BluetoothSearchScreenState extends State<BluetoothSearchScreen> {
  void _updateAvailability(bool status) {
    setState(() {
      widget.availabilityStatus = status;
    });
  }

  void _updateEnableStatus(bool status) {
    setState(() {
      widget.enabledStatus = status;
    });
  }

  void _updateNearbySessions(List<Session> sessions) {
    setState(() {
      widget.nearbySessions = sessions;
    });
  }

  Future _refresh() async {
    bool availableStatus = await Controller.instance().isBluetoothAvailable();
    bool enabledStatus = await Controller.instance().isBluetoothEnabled();
    this._updateAvailability(availableStatus);
    this._updateEnableStatus(enabledStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getAppBar(), body: getBody());
  }

  Widget getAppBar() {
    return AppBar(
      title: Text(
        "Session Search",
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: AppColors.mainColor,
    );
  }

  Widget getBody() {
    return Container(
      color: AppColors.backgroundColor,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          GenericContainer(
              title: "Know what's around you", text: Utility.sessionSearchText),
          this.getChecklist(),
          this.getScanButton(),
          this.getSessionsContainer(),
        ],
      ),
    );
  }

  //
  // Bluetooth status checklist
  //

  Widget getChecklist() {
    return FutureBuilder(
        future: _refresh(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return getCheckListContainer();
        });
  }

  Widget getCheckListContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          drawChecklistItem("Bluetooth Available", widget.availabilityStatus),
          Divider(height: 3),
          drawChecklistItem("Bluetooth Enabled", widget.enabledStatus),
        ],
      ),
    );
  }

  Widget drawChecklistItem(String title, bool status) {
    return Container(
      decoration: new BoxDecoration(color: AppColors.containerColor),
      child: ListTile(
          title: Text(
            title,
          ),
          trailing: status
              ? Icon(Icons.check_circle_outline, color: Colors.green)
              : Icon(Icons.clear, color: Colors.red)),
    );
  }

  //
  // Bluetooth scanning (nearby session)
  //

  Widget getScanButton() {
    return FutureBuilder<bool>(
      future: Controller.instance().isBluetoothOK(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return this.getButton(snapshot.data);
      },
    );
  }

  Future getNearbySessions() async {
    widget.scanEnabled = false;

    Set<int> beaconLocationIDs =
        await Controller.instance().searchForBeaconLocations();
    List<Session> nbSessions =
        await Controller.instance().getSessionsNearby(beaconLocationIDs);

    this._updateNearbySessions(nbSessions);

    widget.scanEnabled = true;
  }

  Widget getButton(bool visibility) {
    return Visibility(
      maintainSize: false,
      visible: visibility,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: RawMaterialButton(
          onPressed: () {
            if (widget.scanEnabled) getNearbySessions();
          },
          child:
              Text("SCAN", style: TextStyle(color: Colors.white, fontSize: 30)),
          shape: new CircleBorder(),
          elevation: 5.0,
          fillColor: AppColors.mainColor,
          padding: const EdgeInsets.all(70.0),
        ),
      ),
    );
  }

  List<Widget> buildSessionContainers() {
    List<Widget> result = List<Widget>();

    result.add(
        GenericContainer(title: "Nearby Sessions:", text: "These are the sessions near you that are starting soon"));

    result.add(Divider());

    for (int i = 0; i < widget.nearbySessions.length; i++) {
      result.add(SessionContainer(activity: widget.nearbySessions[i],));
      result.add(Divider());
    }

    return result;
  }

  Widget getSessionsContainer() {
    List<Widget> sessions = buildSessionContainers();

    // return Column(children: <Widget>[GenericContainer(text: "OLA",title: "ola",touchable: false,)],);
    return Column(children: sessions);
  }

  Widget getSessions() {
    return FutureBuilder(
        future: getNearbySessions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return getSessionsContainer();
        });
  }

  //UNUSED METHODS

  Widget getRefreshButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: RawMaterialButton(
        onPressed: _refresh,
        child: Icon(Icons.refresh, color: Colors.white),
        shape: new CircleBorder(),
        elevation: 5.0,
        fillColor: AppColors.mainColor,
        padding: const EdgeInsets.all(15.0),
      ),
    );
  }
}
