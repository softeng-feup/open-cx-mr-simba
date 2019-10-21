import 'package:ama/components/SessionContainer.dart';
import 'package:ama/data/DaySessionsInfo.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;
import 'package:flutter_slidable/flutter_slidable.dart';


class DaySessionsScreen extends StatelessWidget {
  DaySessionsScreen({this.sessionsInfo});

  final DaySessionsInfo sessionsInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Sessions for  " + sessionsInfo.getDate().toString()),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
            color: AppColors.backgroundColor,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                itemCount: sessionsInfo.getSessions().length,
                itemBuilder: (context, idx) {
                  return Slidable(
                    actionPane: SlidableScrollActionPane(),
                    actionExtentRatio: 0.25,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                        child: SessionContainer(
                          activity: sessionsInfo.getSessions().elementAt(idx),
                        ),
                    ),

                    secondaryActions: <Widget>[
                      SlideAction(
                        closeOnTap: true,
                        color: AppColors.backgroundColor,
                        child: RawMaterialButton(
                          padding: const EdgeInsets.all(10.0),

                          onPressed: () {
                            bool added = sessionsInfo.addFunction(
                                sessionsInfo.getSessions().elementAt(idx));

                            String text;

                            if(added) {
                              text = "Session added to schedule";
                            }
                            else {
                              text = "Session already added to schedule";
                            }

                            Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
                          },

                          child: Icon(Icons.check, color: Colors.white, size: 40.0),
                          shape: CircleBorder(),
                          elevation: 0.0,
                          fillColor: Colors.green,
                        ),

                      )
                    ],


                  );
                })));
  }

  // TODO: swipe left para aparecer botao que adiciona sessao ao horario
}
