import 'dart:collection';

import 'package:ama/components/GenericContainer.dart';
import 'package:ama/components/SlidableSessionContainer.dart';
import 'package:ama/data/DayScheduleInfo.dart';
import 'package:ama/data/DaySessionsInfo.dart';
import 'package:ama/data/Session.dart';
import 'package:flutter/material.dart';
import '../components/SessionContainer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../constants/AppColors.dart' as AppColors;
import '../constants/Utility.dart' as Utility;


class DayScheduleScreen extends StatefulWidget {
  DayScheduleScreen({this.info});

  final DayScheduleInfo info;

  static Session session1 = Session(
  key: "dc03a3e9-5daf4-973c-0941b84ef00b",
  title: "Student Research Competition: Oral Presentation",
  chairString: "Philipp Haller",
  chairKey: "philipphaller",
  itemKeys: ["programming-2019-src-cantor-pairing-in-a-reversible-programming-language-short-presentation-",
  "programming-2019-src-reading-logic-as-code-or-as-natural-language-text-short-presentation-",
  "programming-2019-src-a-framework-for-big-step-semantics-short-presentation-",
  "programming-2019-src-rml-runtime-monitoring-language-short-presentation-",
  "programming-2019-src-baccaml-the-meta-hybrid-just-in-time-compiler-short-presentation-",
  "programming-2019-src-magritte-a-modern-shell-language-short-presentation-"],
  description: "The ACM Student Research Competition (SRC), sponsored by Microsoft Research, offers a unique forum for ACM student members at the undergraduate and graduate levels to present their original research at &lt;Programming&gt; before a panel of judges and conference attendees, and creates opportunities for learning and networking among researchers and practitioners. The SRC gives visibility to not only up-and-coming young researchers, but also to the field of computer science research and its community.",
  type: "Invited Students",
  day: "2019-04-03",
  timeString: "02:30 - 11:00",
  startTime: DateTime.parse("2019-04-03 09:30"),
  location: "Hotel Bristol Palace | Bellini"
  );

  static Session session2 = Session(
  key: "dc03a3e9-5dbd-4af4-973c-0940b",
  title: "Student Research Competition: Oral Presentation",
  chairString: "Philipp Haller",
  chairKey: "philipphaller",
  itemKeys: ["programming-2019-src-cantor-pairing-in-a-reversible-programming-language-short-presentation-",
  "programming-2019-src-reading-logic-as-code-or-as-natural-language-text-short-presentation-",
  "programming-2019-src-a-framework-for-big-step-semantics-short-presentation-",
  "programming-2019-src-rml-runtime-monitoring-language-short-presentation-",
  "programming-2019-src-baccaml-the-meta-hybrid-just-in-time-compiler-short-presentation-",
  "programming-2019-src-magritte-a-modern-shell-language-short-presentation-"],
  description: "The ACM Student Research Competition (SRC), sponsored by Microsoft Research, offers a unique forum for ACM student members at the undergraduate and graduate levels to present their original research at &lt;Programming&gt; before a panel of judges and conference attendees, and creates opportunities for learning and networking among researchers and practitioners. The SRC gives visibility to not only up-and-coming young researchers, but also to the field of computer science research and its community.",
  type: "Invited Students",
  day: "2019-04-03",
  timeString: "08:30 - 11:00",
  startTime: DateTime.parse("2019-04-03 09:30"),
  location: "Hotel Bristol Palace | Bellini"
  );

  static Session session3 = Session(
      key: "dc03a3e9-5dbd-4af4-973c-0941b84ef00b",
      title: "Student Research Competition: Oral Presentation",
      chairString: "Philipp Haller",
      chairKey: "philipphaller",
      itemKeys: ["programming-2019-src-cantor-pairing-in-a-reversible-programming-language-short-presentation-",
        "programming-2019-src-reading-logic-as-code-or-as-natural-language-text-short-presentation-",
        "programming-2019-src-a-framework-for-big-step-semantics-short-presentation-",
        "programming-2019-src-rml-runtime-monitoring-language-short-presentation-",
        "programming-2019-src-baccaml-the-meta-hybrid-just-in-time-compiler-short-presentation-",
        "programming-2019-src-magritte-a-modern-shell-language-short-presentation-"],
      description: "The ACM Student Research Competition (SRC), sponsored by Microsoft Research, offers a unique forum for ACM student members at the undergraduate and graduate levels to present their original research at &lt;Programming&gt; before a panel of judges and conference attendees, and creates opportunities for learning and networking among researchers and practitioners. The SRC gives visibility to not only up-and-coming young researchers, but also to the field of computer science research and its community.",
      type: "Invited Students",
      day: "2019-04-03",
      timeString: "10:30 - 11:00",
      startTime: DateTime.parse("2019-04-03 09:30"),
      location: "Hotel Bristol Palace | Bellini"
  );



  @override
  DayScheduleScreenState createState() => DayScheduleScreenState();
}

class DayScheduleScreenState extends State<DayScheduleScreen> {

  bool _removeSession(Session session) {
    bool removed;

    setState(() {
      removed = widget.info.getSessions().remove(session);
    });

    return removed;
  }

  bool _addSession(Session session) {
    bool added;

    setState(() {
      added = widget.info.getSessions().add(session);
    });

    return added;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Day " + widget.info.getDay().toString() + " Schedule"),
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
          child: Column(
            children: <Widget>[
              Visibility(
                maintainSize: false,
                visible: (widget.info.getSessions().length == 0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GenericContainer(title: Utility.noSessionsTitle, text: Utility.noSessionsText),
                ),
              ),

              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0, bottom: 70.0),
                    itemCount: widget.info.getSessions().length,
                    itemBuilder: (context, idx) {
                      return SlidableSessionContainer(
                        session: widget.info.getSessions().elementAt(idx),
                        icon: Icons.delete,
                        color: Colors.red,
                        onPressFunction: () {
                          _removeSession(widget.info.getSessions().elementAt(idx));
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Session deleted from schedule")));
                        },
                      );
                    }

                  // TODO: swipe left para aparecer botao que retira sessao do horario

                    /*children: <Widget>[
                     SessionContainer(
                    activity: Session(
                        key: "dc03a3e9-5dbd-4af4-973c-0941b84ef00b",
                        title: "Student Research Competition: Oral Presentation",
                        chairString: "Philipp Haller",
                        chairKey: "philipphaller",
                        itemKeys: ["programming-2019-src-cantor-pairing-in-a-reversible-programming-language-short-presentation-",
                                   "programming-2019-src-reading-logic-as-code-or-as-natural-language-text-short-presentation-",
                                   "programming-2019-src-a-framework-for-big-step-semantics-short-presentation-",
                                   "programming-2019-src-rml-runtime-monitoring-language-short-presentation-",
                                   "programming-2019-src-baccaml-the-meta-hybrid-just-in-time-compiler-short-presentation-",
                                   "programming-2019-src-magritte-a-modern-shell-language-short-presentation-"],
                        description: "The ACM Student Research Competition (SRC), sponsored by Microsoft Research, offers a unique forum for ACM student members at the undergraduate and graduate levels to present their original research at &lt;Programming&gt; before a panel of judges and conference attendees, and creates opportunities for learning and networking among researchers and practitioners. The SRC gives visibility to not only up-and-coming young researchers, but also to the field of computer science research and its community.",
                        type: "Invited Students",
                        day: "2019-04-03",
                        timeString: "09:30 - 11:00",
                        startTime: DateTime.parse("2019-04-03 09:30"),
                        location: "Hotel Bristol Palace | Bellini"
                    ),
                  ),

                    SessionContainer(
                      activity: Session(
                          key: "dc03a3e9-5dbd-4af4-973c-0941b84ef00b",
                          title: "Student Research Competition: Oral Presentation",
                          chairString: "Philipp Haller",
                          chairKey: "philipphaller",
                          itemKeys: ["programming-2019-src-cantor-pairing-in-a-reversible-programming-language-short-presentation-",
                            "programming-2019-src-reading-logic-as-code-or-as-natural-language-text-short-presentation-",
                            "programming-2019-src-a-framework-for-big-step-semantics-short-presentation-",
                            "programming-2019-src-rml-runtime-monitoring-language-short-presentation-",
                            "programming-2019-src-baccaml-the-meta-hybrid-just-in-time-compiler-short-presentation-",
                            "programming-2019-src-magritte-a-modern-shell-language-short-presentation-"],
                          description: "The ACM Student Research Competition (SRC), sponsored by Microsoft Research, offers a unique forum for ACM student members at the undergraduate and graduate levels to present their original research at &lt;Programming&gt; before a panel of judges and conference attendees, and creates opportunities for learning and networking among researchers and practitioners. The SRC gives visibility to not only up-and-coming young researchers, but also to the field of computer science research and its community.",
                          type: "Invited Students",
                          day: "2019-04-03",
                          timeString: "09:30 - 11:00",
                          startTime: DateTime.parse("2019-04-03 09:30"),
                          location: "Hotel Bristol Palace | Bellini"
                      ),
                    ),

                    SessionContainer(
                      activity: Session(
                          key: "f3dc5937-50c4-48f8-a93b-b739fd7dae01",
                          title: "Catering: Lunch",
                          itemKeys: ["programming-2019-catering-lunch"],
                          description: "Lunch, Dinner, Coffee-breaks",
                          type: "Accepted Papers",
                          day: "2019-04-04",
                          timeString: "12:30 - 14:00",
                          startTime: DateTime.parse("2019-04-04 12:30"),
                          location: "Hotel Bristol Palace | ​Lunch area"
                      ),
                    ),

                    SessionContainer(
                      activity: Session(
                          key: "f3dc5937-50c4-48f8-a93b-b739fd7dae01",
                          title: "Catering: Lunch",
                          itemKeys: ["programming-2019-catering-lunch"],
                          description: "Lunch, Dinner, Coffee-breaks",
                          type: "Accepted Papers",
                          day: "2019-04-04",
                          timeString: "12:30 - 14:00",
                          startTime: DateTime.parse("2019-04-04 12:30"),
                          location: "Hotel Bristol Palace | ​Lunch area"
                      ),
                    ),

                    SessionContainer(
                      activity: Session(
                          key: "f3dc5937-50c4-48f8-a93b-b739fd7dae01",
                          title: "Catering: Lunch",
                          itemKeys: ["programming-2019-catering-lunch"],
                          description: "Lunch, Dinner, Coffee-breaks",
                          type: "Accepted Papers",
                          day: "2019-04-04",
                          timeString: "12:30 - 14:00",
                          startTime: DateTime.parse("2019-04-04 12:30"),
                          location: "Hotel Bristol Palace | ​Lunch area"
                      ),
                    ),

                    SessionContainer(
                      activity: Session(
                          key: "f3dc5937-50c4-48f8-a93b-b739fd7dae01",
                          title: "Research Papers: Live Programming",
                          itemKeys: ["programming-2019-catering-lunch"],
                          description: "Lunch, Dinner, Coffee-breaks",
                          type: "Accepted Papers",
                          day: "2019-04-04",
                          timeString: "12:30 - 14:00",
                          startTime: DateTime.parse("2019-04-04 12:30"),
                          location: "Hotel Bristol Palace | ​Lunch area"
                      ),
                    ),

                    SessionContainer(
                      activity: Session(
                          key: "f3dc5937-50c4-48f8-a93b-b739fd7dae01",
                          title: "Catering: Lunch",
                          itemKeys: ["programming-2019-catering-lunch"],
                          description: "Lunch, Dinner, Coffee-breaks",
                          type: "Accepted Papers",
                          day: "2019-04-04",
                          timeString: "12:30 - 14:00",
                          startTime: DateTime.parse("2019-04-04 12:30"),
                          location: "Hotel Bristol Palace | ​Lunch area"
                      ),
                    ),

                    SessionContainer(
                      activity: Session(
                          key: "f3dc5937-50c4-48f8-a93b-b739fd7dae01",
                          title: "Catering: Lunch",
                          itemKeys: ["programming-2019-catering-lunch"],
                          description: "Lunch, Dinner, Coffee-breaks",
                          type: "Accepted Papers",
                          day: "2019-04-04",
                          timeString: "12:30 - 14:00",
                          startTime: DateTime.parse("2019-04-04 12:30"),
                          location: "Hotel Bristol Palace | ​Lunch area"
                      ),
                    ),
         ]*/
                    ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {

                // TODO: usar funcoes json para extrair as sessoes de cada dia

                SplayTreeSet<Session> set = SplayTreeSet.from([DayScheduleScreen.session3, DayScheduleScreen.session1, DayScheduleScreen.session2]);

                Navigator.pushNamed(context, '/daySessionsScreen', arguments: DaySessionsInfo(widget.info.getDate(), set, _addSession));

            }, // adicionar depois push para SessionsScreen (ir ao json buscar as sessoes desse dia)
            backgroundColor: AppColors.mainColor,
            foregroundColor: Colors.white,
            elevation: 20.0,
            icon: Icon(Icons.add),
            label: Text(
              "ADD",
              style: TextStyle(fontSize: 25),
            )));
  }
}
