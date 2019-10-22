import 'package:ama/components/SessionContainer.dart';
import 'package:ama/data/Session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../constants/AppColors.dart' as AppColors;

class SlidableSessionContainer extends StatelessWidget {
  SlidableSessionContainer(
      {this.session, this.icon, this.color, this.onPressFunction});

  final Session session;
  final IconData icon;
  final Color color;
  final Function onPressFunction;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SessionContainer(
          activity: session,
        ),
      ),
      secondaryActions: <Widget>[
        Container(
          color: AppColors.backgroundColor,
          child: RawMaterialButton(
            padding: const EdgeInsets.all(10.0),
            onPressed: () {
              onPressFunction();
              // Slidable.of(context).close(); // TODO: fazer com que slider feche (diz que é null)
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
