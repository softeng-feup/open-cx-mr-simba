import 'package:ama/controller/Controller.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:ama/view/components/SessionContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../constants/AppColors.dart' as AppColors;

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
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
      floatingActionButton: getScanButton(),
    );
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
      actions: <Widget>[
        getBluetoothStatusIcon(),
        IconButton(
          icon: Icon(Icons.info_outline, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/bluetoothAbout');
          },
        ),
      ],
    );
  }

  Widget getBody() {
    return Container(
      color: AppColors.backgroundColor,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          this.getIntroductionContainer(),
          this.getSessionsContainer(),
        ],
      ),
    );
  }

  //
  // Bluetooth status checklist
  //

  Widget getIntroductionContainer() {
    String introText;

    if (!widget.enabledStatus)
      introText = "But you'll need to enable bluetooth first...";
    else
      introText = "Tap the 'scan' button whenever you're ready to explore.";

    return GenericContainer(title: "Know what's around you", text: introText);
  }

  Widget getBluetoothStatusIcon() {
    return FutureBuilder(
        future: _refresh(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return (widget.enabledStatus
              ? Icon(Icons.bluetooth, color: Colors.white)
              : Icon(Icons.bluetooth_disabled, color: Colors.white));
        });
  }

  //
  // Bluetooth scanning (nearby session)
  //

  Widget getScanButton() {
    return FutureBuilder<bool>(
      future: Controller.instance().isBluetoothOK(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return this.getFloatingButton(snapshot.data);
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

  Widget getFloatingButton(bool visibility) {
    return Visibility(
      visible: visibility,
      child: FloatingActionButton(
        onPressed: () {
          if (widget.scanEnabled) getNearbySessions();
        },
        tooltip: 'Scan',
        backgroundColor: AppColors.mainColor,
        child: Icon(Icons.search),
      ),
    );
  }

  List<Widget> buildSessionContainers() {
    List<Widget> result = List<Widget>();

    result.add(Divider());

    for (int i = 0; i < widget.nearbySessions.length; i++) {
      result.add(SessionContainer(
        activity: widget.nearbySessions[i],
      ));
      result.add(Divider());
    }



    return result;
  }

  Widget getSessionsContainer() {
    List<Widget> sessions = buildSessionContainers();

    if(!widget.scanEnabled){
      return Padding(
        padding: const EdgeInsets.only(top:125.0),
        child: Image(image: AssetImage("assets/images/AMA.gif")),
      );
    }

    if(sessions.length == 1){

      return
        Padding(
          padding: const EdgeInsets.only(top:200.0),
          child: Text("Looks like there are no sessions nearby.", style: TextStyle(fontSize: 20,color: Colors.black87),textAlign: TextAlign.center,),
        );
    }

    return Column(children: sessions);
  }



  //UNUSED METHODS

    Widget getSessions() {
    return FutureBuilder(
        future: getNearbySessions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          switch(snapshot.connectionState){

            case ConnectionState.waiting:

              return Image(image: AssetImage("assets/images/AMA.gif"));
              break;
            default:
              break;
          }

          return getSessionsContainer();
        });
  }

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
}

Widget getButton(bool visibility) {
  return Visibility(
    maintainSize: false,
    visible: visibility,
    child: Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: RawMaterialButton(
        onPressed: () {
          // if (widget.scanEnabled) getNearbySessions();
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
