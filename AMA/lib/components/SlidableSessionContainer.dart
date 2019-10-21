import 'package:ama/components/SessionContainer.dart';
import 'package:ama/data/Session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../constants/AppColors.dart' as AppColors;

class SlidableSessionContainer extends StatefulWidget {
  SlidableSessionContainer({this.session, this.icon, this.color, this.onPressFunction});

  final Session session;
  final IconData icon;
  final Color color;
  final Function onPressFunction;

  @override
  SlidableSessionContainerState createState() => SlidableSessionContainerState();
}

class SlidableSessionContainerState extends State<SlidableSessionContainer> {

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SessionContainer(
          activity: widget.session,
        ),
      ),

      secondaryActions: <Widget>[
        SlideAction(
          closeOnTap: true,
          color: AppColors.backgroundColor,
          child: RawMaterialButton(
            padding: const EdgeInsets.all(10.0),
            onPressed: () { widget.onPressFunction(); },
            child: Icon(widget.icon, color: Colors.white, size: 40.0),
            shape: CircleBorder(),
            elevation: 0.0,
            fillColor: widget.color,
          ),

        )
      ],


    );
  }
}