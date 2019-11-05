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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Session Search",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: Container(
          color: AppColors.backgroundColor,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              GenericContainer(
                  title: "Know what's around you",
                  text: Utility.sessionSearchText),
              this.drawChecklist(),
              this.drawScanButton(),
            ],
          ),
        ));
  }

  // Currently Unused
  Widget drawRefreshButton() {
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

  Widget getCheckListContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(color: AppColors.containerColor),
            child: ListTile(
                title: Text(
                  "Bluetooth Available",
                ),
                trailing: widget.availabilityStatus
                    ? Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.clear,
                        color: Colors.red,
                      )),
          ),
          Divider(
            height: 3,
          ),
          Container(
            decoration: new BoxDecoration(color: AppColors.containerColor),
            child: ListTile(
                title: Text(
                  "Bluetooth Enabled",
                ),
                trailing: widget.enabledStatus
                    ? Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.clear,
                        color: Colors.red,
                      )),
          ),
        ],
      ),
    );
  }

  Widget drawChecklist() {
    return FutureBuilder(
        future: _refresh(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return getCheckListContainer();
        });
  }

  Widget drawScanButton() {
    return FutureBuilder<bool>(
      future: Controller.instance().isBluetoothOK(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return this.drawButton(snapshot.data);
      },
    );
  }

  Widget drawButton(bool visibility) {
    return Visibility(
      maintainSize: false,
      visible:
          visibility, // TODO: mostrar botao se se puder usar BT (available e enabled)
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: RawMaterialButton(
          onPressed: () {
            // processamento feito em BluetoothController; esta classe nao sabe como
            // a ligacao controller.bluetooth acontece, apenas recebe a informacao
            // passa as informacoes para outra pagina, para dar display
            // a outra pagina vai buscar ao json a informacao correta e da display

            List<String> locations =
                Controller.instance().searchForBeaconLocations();
            // SplayTreeSet<Session> nearbySessions =
            //     Controller.instance().getSessionsNearby(locations);
            // TODO: fazer display de nearbySessions numa nova pagina
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
}
