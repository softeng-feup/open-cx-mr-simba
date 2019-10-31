import 'package:ama/controller/Controller.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class BluetoothSearchScreen extends StatelessWidget {

  @override
    Widget build(BuildContext context) {

    bool isAvailable = Controller.instance().isBluetoothAvailable();
    bool isEnabled = Controller.instance().isBluetoothEnabled();

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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                  child: GenericContainer(
                    title: "Know what's around you",
                    text: Utility.sessionSearchText
                  ),
                ),
                this.drawBTUnavailableMessage(isAvailable),
                this.drawBTDisabledMessage(isEnabled),
                this.drawButton(isAvailable, isEnabled),
              ],
            ),
          )
      );
    }


    Widget drawBTUnavailableMessage(bool isAvailable) {
      return Visibility (
        maintainSize: false,
        visible: !isAvailable,
        child: Padding(
          padding: const EdgeInsets.only(top: 160.0),
          child: GenericContainer(
              title: "Bluetooth not available", text: Utility.BTNotAvailableText,
        ),
        )
      );
    }


    Widget drawBTDisabledMessage(bool isEnabled) {

    }


    Widget drawButton(bool isAvailable, bool isEnabled) {
      return Visibility(
        maintainSize: false,
        visible: false,// TODO: se se puder usar BT

        child: Padding(
          padding: const EdgeInsets.only(top: 160.0),
          child: RawMaterialButton(
            onPressed: () {

              // TODO: comeca a dar scan de devices e recebe informacao
              // processamento feito em BluetoothController; esta classe nao sabe como
              // a ligacao controller.bluetooth acontece, apenas recebe a informacao
              // passa as informacoes para outra pagina, para dar display
              // a outra pagina vai buscar ao json a informacao correta e da display


            },
            child: Text("SCAN", style: TextStyle(color: Colors.white, fontSize: 30)),
            shape: new CircleBorder(),
            elevation: 5.0,
            fillColor: AppColors.mainColor,
            padding: const EdgeInsets.all(70.0),
          ),
        ),
      );
    }
}