import 'dart:math';

import 'package:ama/constants/Dates.dart';
import 'package:ama/controller/Controller.dart';
import 'package:ama/model/Person.dart';
import 'package:ama/view/components/GenericTitle.dart';
import 'package:ama/controller/Controller.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class MainScreenPage extends StatelessWidget {
  MainScreenPage({this.dayNo, this.date});

  final int dayNo;
  final Date date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: Key("Calendar page"),
        onTap: () {
          String routeOnTap = "/day" + dayNo.toString() + "Screen";
          Navigator.pushNamed(context, routeOnTap);
        },
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: new SmallCalendarPage(
                  date: date,
                  dayNo: dayNo,
                )),
            FeaturedSpeakersPage(
              date: date,
              dayNo: dayNo,
            )
          ],
        ));
  }
}

class FeaturedSpeakersPage extends StatelessWidget {
  final Date date;
  final int dayNo;
  List<Person> people = null;

  FeaturedSpeakersPage({
    Key key,
    this.date,
    this.dayNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 32 / 100,
        width: MediaQuery.of(context).size.width *  65 / 100,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(20),
          color: AppColors.containerColor,
          border: Border.all(width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GenericTitle(
                  title: "Featured Speakers:",
                  backgroundColor: AppColors.containerColor,
                  padding: EdgeInsets.all(6.0),
                  margin: EdgeInsets.only(top: 10.0),
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 18)),
            ),
            printSpeakers(),
          ],
        ),
      ),
    );
  }

  Widget printSpeakers() {
    return FutureBuilder(
        future: Controller.instance().getDaySpeakers(this.date.toDateString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Person> dbSpeakers = snapshot.data;

            dbSpeakers = shuffle(dbSpeakers);

            if (this.people == null) this.people = dbSpeakers;

            print(this.people.elementAt(0).name);
            print(this.people.elementAt(1).name);
            print(this.people.elementAt(2).name);
            print(this.people.elementAt(3).name);

            Person speaker1 = this.people.elementAt(0);
            Person speaker2 = this.people.elementAt(1);
            Person speaker3 = this.people.elementAt(2);
            Person speaker4 = this.people.elementAt(3);

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(flex: 1, child:printAvatar(speaker1) ),
                    Flexible(flex: 1, child:printAvatar(speaker2) ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(flex: 1, child:printAvatar(speaker3) ),
                      Flexible(flex: 1, child:printAvatar(speaker4) ),
                    ],
                  ),
                ),
              ],
            );
          }
          else{

            return Container();
          }
        });
  }

  printAvatar(Person person) {



    if (person.imageURL != null)
      return Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(person.imageURL),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(person.name,style: TextStyle(color: Colors.black87),maxLines: 1,overflow: TextOverflow.ellipsis, softWrap: false,),
          ),
        ],
      );
    else {
      return Column(
        children: <Widget>[
          CircleAvatar(
              radius: 30,
              child: Text(
                getInitials(person.name),
                style: TextStyle(fontSize: 10),
              )),
          Text(person.name,style: TextStyle(color: Colors.black87),),
        ],
      );
    }
  }

  String getInitials(String text) {
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      return '$first';
    });
    return capitalized.join(' ');
  }
}

class SmallCalendarPage extends StatelessWidget {
  final Date date;
  final int dayNo;

  const SmallCalendarPage({
    Key key,
    this.date,
    this.dayNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 40 / 100,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(width: 2),
      ),
      child: this.drawCalendar(context),
    );
  }

  Widget drawCalendar(BuildContext context) {
    String text = Controller.instance().getTextActivities(dayNo);

    return ClipRRect(
      borderRadius: new BorderRadius.circular(16),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text(date.getWeekDay(), style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.red,
          leading: Padding(
            padding: const EdgeInsets.all(8.5),
            child: Text("#" + dayNo.toString(),
                style: TextStyle(fontSize: 30), key: Key("identifierDay")),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                date.getDay(),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.15,
                    color: Colors.black),
              ),
              Text(
                date.getMonthStr(),
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  key: Key("numberOfActivitiesDay"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List shuffle(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}
