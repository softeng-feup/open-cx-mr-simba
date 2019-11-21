import 'package:ama/model/Session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class NotifsController {
    static NotifsController _instance;
    FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

    static NotifsController instance() {
      if (_instance == null) _instance = new NotifsController();

      return _instance;
    }

    NotifsController() {
      _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      var initializationSettingsAndroid = new AndroidInitializationSettings('amalogo');
      var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
      _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _onSelectNotification);
    }


    Future _onSelectNotification(String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
//        Navigator.pushNamed(context, '/sessionScreen', arguments: activity);
      }
    }

    Future _onDidReceiveLocalNotification(int id, String title, String body, String payload) async {

    }

    Future scheduleNotificationForSession(Session session) async {
      var scheduledNotificationDateTime = session.startTime.subtract(new Duration(minutes: 10));
      print(new DateFormat.yMd().add_jm().format(scheduledNotificationDateTime));

      var androidPlatformChannelSpecifics =
      new AndroidNotificationDetails('channel id', 'channel name', 'channel description');
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      NotificationDetails platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await _flutterLocalNotificationsPlugin.schedule(
          session.key.hashCode,
          'Get ready!',
          'Session "' + session.title + '", to be held at ' + session.location + ", will start in 10 minutes.",
          scheduledNotificationDateTime,
          platformChannelSpecifics,
          androidAllowWhileIdle: true);
      // TODO: depois ver se e preciso meter payload
    }


    Future removeNotificationForSession(Session session) async {
      await _flutterLocalNotificationsPlugin.cancel(session.key.hashCode);
    }

}