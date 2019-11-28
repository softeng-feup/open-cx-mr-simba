import 'package:ama/controller/Controller.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:ama/view/components/GenericTitle.dart';
import 'package:ama/view/components/SlidableSessionContainer.dart';
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
    if (this.mounted) {
      setState(() {
        widget.availabilityStatus = status;
      });
    }
  }

  void _updateEnableStatus(bool status) {
    if (this.mounted) {
      setState(() {
        widget.enabledStatus = status;
      });
    }
  }

  void _updateNearbySessions(List<Session> sessions) {
    if (this.mounted) {
      setState(() {
        widget.nearbySessions = sessions;
      });
    }
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
        getInfoBarButton(),
      ],
    );
  }

  Widget getInfoBarButton() {
    return IconButton(
        icon: Icon(Icons.info_outline, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/bluetoothAbout');
        });
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

  Widget getIntroductionContainer() {
    String introText;

    if (!widget.enabledStatus)
      introText = "But you'll need to enable bluetooth first...";
    else
      introText = "Tap the 'scan' button whenever you're ready to explore.";

    return GenericContainer(title: "Know what's around ", text: introText);
  }

  //
  // Bluetooth status
  //

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

  Widget getSessionsContainer() {
    List<Widget> sessions = buildSessionContainers();

    if (!widget.scanEnabled) {
      return Padding(
        padding: const EdgeInsets.only(top: 125.0),
        child: Image(image: AssetImage("assets/images/AMA.gif")),
      );
    }

    if (sessions.length == 2) {
      return Padding(
        padding: const EdgeInsets.only(top: 200.0),
        child: Text(
          "Looks like there are no sessions nearby :(",
          style: TextStyle(fontSize: 20, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(children: sessions);
  }

  List<Widget> buildSessionContainers() {
    List<Widget> result = List<Widget>();

    Widget title = GenericTitle(
      title: "Sessions Near you",
      padding: EdgeInsets.all(6.0),
      margin: EdgeInsets.all(10.0),
      style: TextStyle(
          color: AppColors.mainColor,
          fontWeight: FontWeight.w900,
          fontSize: 20),
    );

    result.add(title);

    result.add(Divider());

    for (int i = 0; i < widget.nearbySessions.length; i++) {
      result.add(new SlidableSessionContainer(
          session: widget.nearbySessions[i],
          icon: Icons.check,
          color: Colors.green,
          onPressFunction: () async {
            String text = await Controller.instance()
                .addSessionToSchedule(widget.nearbySessions[i]);
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
          }));
      result.add(Divider());
    }

    return result;
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

  //
  // Scan button
  //

  Widget getScanButton() {
    return FutureBuilder<bool>(
      future: Controller.instance().isBluetoothOK(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return this.getFloatingButton(snapshot.data);
      },
    );
  }

  Widget getFloatingButton(bool visibility) {
    if (visibility == null) visibility = false;

    return Visibility(
      visible: visibility,
      child: FloatingActionButton(
        onPressed: () {
          if (widget.scanEnabled) getNearbySessions();
        },
        tooltip: 'Scan',
        backgroundColor:
            widget.scanEnabled ? AppColors.mainColor : Colors.black38,
        child: widget.scanEnabled
            ? Icon(Icons.search)
            : Icon(Icons.not_interested),
      ),
    );
  }
}
