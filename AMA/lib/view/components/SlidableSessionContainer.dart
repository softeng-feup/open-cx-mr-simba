import 'package:ama/model/Session.dart';
import 'package:ama/view/components/SessionContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../constants/AppColors.dart' as AppColors;

class SlidableSessionContainer extends StatelessWidget {
  SlidableSessionContainer(
      {this.session, this.icon, this.color, this.onPressFunction});

  final Session session;
  final IconData icon;
  final Color color;
  final Function onPressFunction;

  final _slidableKey = GlobalKey<SlidableState>();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: _slidableKey,
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SessionContainer(activity: session,),

      ),
      secondaryActions: <Widget>[
        Container(
          color: AppColors.backgroundColor,
          child: RawMaterialButton(
            key: Key("Slidable button"),
            padding: const EdgeInsets.all(10.0),
            onPressed: () {
              onPressFunction();
              _slidableKey.currentState.close();
            },
            child: Icon(icon, color: Colors.white, size: 40.0),
            shape: CircleBorder(),
            elevation: 0.0,
            fillColor: color,
          ),
        )
      ],
    );
  }
}
