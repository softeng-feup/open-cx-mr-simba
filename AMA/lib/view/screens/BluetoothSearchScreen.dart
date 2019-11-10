import 'dart:collection';

import 'package:ama/controller/Controller.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class BluetoothSearchScreen extends StatefulWidget {
  bool availabilityStatus = true;
  bool enabledStatus = true;
  bool scanVisible = true;
  bool scanEnabled = true;
  // List<String> nearbySessions;

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

  Future _refresh() async {
    bool availableStatus = await Controller.instance().isBluetoothAvailable();
    bool enabledStatus = await Controller.instance().isBluetoothEnabled();
    this._updateAvailability(availableStatus);
    this._updateEnableStatus(enabledStatus);
  }


  List<Widget> updateSessions(){

    // Controller.instance();

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

  Widget getScanButton() {
    return FutureBuilder<bool>(
      future: Controller.instance().isBluetoothOK(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return this.getButton(snapshot.data);
      },
    );
  }

  void getNearbySessions() {
    setState(() {
      // widget.nearbySessions = Controller.instance().searchForBeaconLocations();
    });
  }

  Widget getButton(bool visibility) {
    return Visibility(
      maintainSize: false,
      visible:visibility, 

      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: RawMaterialButton(
          onPressed: () {

            

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

  List<Widget> buildSessionContainers(){

    // List<Widget> result;

    // for(int i = 0; i < widget.nearbySessions.length;i++){

    //   result.add( Container(
    //   decoration: new BoxDecoration(color: AppColors.containerColor),
    //   child: ListTile(
    //       title: Text(
    //         widget.nearbySessions[i],
    //       ),
    //   )));
    // }

    // return result;
  }


  Widget getSessionsContainer() {

    List<Widget> sessions = buildSessionContainers();


    return  ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          GenericContainer(
              title: "Sessions", text: Utility.sessionSearchText),
          
        ],
      );

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
