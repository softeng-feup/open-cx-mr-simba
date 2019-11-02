import 'dart:collection';

import 'package:ama/controller/Controller.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class BluetoothSearchScreen extends StatefulWidget {
  bool availabilityStatusVisible = false;
  bool enabledStatusVisible = false;
  bool scanVisible = false;
  String availabilityStatusText;
  String enabledStatusText;

  @override
  BluetoothSearchScreenState createState() => BluetoothSearchScreenState();
}

class BluetoothSearchScreenState extends State<BluetoothSearchScreen> {
  void _updateAvailability(String str) {
    setState(() {
      if (widget.availabilityStatusVisible) {
        widget.availabilityStatusVisible = false;
        return;
      }

      widget.availabilityStatusText = str;
      widget.availabilityStatusVisible = true;
    });
  }

  void _updateEnableStatus(String str) {
    setState(() {
      if (widget.enabledStatusVisible) {
        widget.enabledStatusVisible = false;
        return;
      }

      widget.enabledStatusText = str;
      widget.enabledStatusVisible = true;
    });
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
              RawMaterialButton(
                onPressed: () {
                  
                },
                child: Icon(Icons.refresh, color: Colors.white),
                shape: new CircleBorder(),
                elevation: 5.0,
                fillColor: AppColors.mainColor,
                padding: const EdgeInsets.all(70.0),
              ),

              // this.drawCheckAvailabilityButton(),
              // this.drawCheckEnableButton(),
              // this.test(),
            ],
          ),
        ));
  }

  Widget drawChecklist() {
    return Container(
        height: 200,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(color: AppColors.containerColor),
              child: ListTile(
                  title: Text(
                    "Bluetooth Available",
                  ),
                  trailing: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
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
                  trailing: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  )),
            ),
          ],
        ));
  }

  Widget test() {
    return FutureBuilder<bool>(
      future: Controller.instance().isBluetoothOK(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) return this.drawButton(false);
            return this.drawButton(snapshot.data);
          default:
            return this.drawButton(false);
        }
      },
    );
  }

  Widget drawCheckAvailabilityButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          RawMaterialButton(
            onPressed: () async {
              String availableText =
                  await Controller.instance().isBluetoothAvailable()
                      ? Utility.BTAvailableText
                      : Utility.BTAvailableText;
              this._updateAvailability(availableText);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Check BT Availability",
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0)),
            elevation: 0.0,
            fillColor: AppColors.mainColor,
            padding: const EdgeInsets.all(10.0),
          ),
          Visibility(
              maintainSize: false,
              visible: widget.availabilityStatusVisible,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GenericContainer(
                  title: "Bluetooth Availability",
                  text: widget.availabilityStatusText,
                ),
              )),
        ],
      ),
    );
  }

  Widget drawCheckEnableButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          RawMaterialButton(
            onPressed: () async {
              String enabledText =
                  await Controller.instance().isBluetoothEnabled()
                      ? Utility.BTEnabledText
                      : Utility.BTDisabledText;
              this._updateEnableStatus(enabledText);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Check if BT is Enabled",
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0)),
            elevation: 0.0,
            fillColor: AppColors.mainColor,
            padding: const EdgeInsets.all(10.0),
          ),
          Visibility(
              maintainSize: false,
              visible: widget.enabledStatusVisible,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GenericContainer(
                  title: "Bluetooth Availability",
                  text: widget.enabledStatusText,
                ),
              )),
        ],
      ),
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
            SplayTreeSet<Session> nearbySessions =
                Controller.instance().getSessionsNearby(locations);
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

// class BluetoothSearchScreen extends StatelessWidget {

//   @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               "Session Search",
//               style: TextStyle(color: Colors.white),
//             ),
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.white,
//               ),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             backgroundColor: AppColors.mainColor,
//           ),
//           body: Container(
//             color: AppColors.backgroundColor,
//             child: ListView(
//               scrollDirection: Axis.vertical,
//               padding: EdgeInsets.all(10.0),
//               children: <Widget>[
//                 GenericContainer(
//                   title: "Know what's around you",
//                   text: Utility.sessionSearchText
//                 ),
//                 this.drawCheckAvailabilityButton(),
//                 // this.drawCheckEnableButton(),
//                 // this.drawButton(),
//               ],
//             ),
//           )
//       );
//     }

//     Widget drawCheckAvailabilityButton() {

//       return Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: Column(
//           children: <Widget>[
//             RawMaterialButton(
//               onPressed: () async {
//                 answerVisible = false;
//                 availableText = await Controller.instance().isBluetoothAvailable();
//                 print("Pressinou");
//                 answerVisible = true;
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("Check BT Availability", style: TextStyle(color: Colors.white, fontSize: 25)),
//               ),
//               shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//               elevation: 0.0,
//               fillColor: AppColors.mainColor,
//               padding: const EdgeInsets.all(10.0),
//             ),

//             Visibility (
//               maintainSize: false,
//               visible: answerVisible,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 160.0),
//                 child: GenericContainer(
//                     title: "Bluetooth Availability", text: availableText,
//               ),
//               )
//             ),
//           ],
//         ),
//       );
//     }

//     Widget drawCheckEnableButton() {
//       bool answerVisible = false;
//       String enabledText;

//       return Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: Column(
//           children: <Widget>[
//             RawMaterialButton(
//               onPressed: () async {
//                 answerVisible = false;
//                 enabledText = await Controller.instance().isBluetoothEnabled();
//                 answerVisible = true;
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("Check if BT is Enabled", style: TextStyle(color: Colors.white, fontSize: 25)),
//               ),
//               shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//               elevation: 0.0,
//               fillColor: AppColors.mainColor,
//               padding: const EdgeInsets.all(10.0),
//             ),

//             Visibility (
//                 maintainSize: false,
//                 visible: answerVisible,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 160.0),
//                   child: GenericContainer(
//                     title: "Bluetooth Availability", text: enabledText,
//                   ),
//                 )
//             ),
//            ],
//          ),
//         );
//       }

//     Widget drawButton() {
//       return Visibility(
//         maintainSize: false,
//         visible: false,// TODO: mostrar botao se se puder usar BT (available e enabled)

//         child: Padding(
//           padding: const EdgeInsets.only(top: 160.0),
//           child: RawMaterialButton(
//             onPressed: () {
//               // processamento feito em BluetoothController; esta classe nao sabe como
//               // a ligacao controller.bluetooth acontece, apenas recebe a informacao
//               // passa as informacoes para outra pagina, para dar display
//               // a outra pagina vai buscar ao json a informacao correta e da display

//               List<String> locations = Controller.instance().searchForBeaconLocations();
//               SplayTreeSet<Session> nearbySessions = Controller.instance().getSessionsNearby(locations);
//               // TODO: fazer display de nearbySessions numa nova pagina
//             },
//             child: Text("SCAN", style: TextStyle(color: Colors.white, fontSize: 30)),
//             shape: new CircleBorder(),
//             elevation: 5.0,
//             fillColor: AppColors.mainColor,
//             padding: const EdgeInsets.all(70.0),
//           ),
//         ),
//       );
//     }
// }
