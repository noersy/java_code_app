import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

firebaseConfiguration() async {
  subscribeNotif();
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var androidInitialize = const AndroidInitializationSettings('ic_launcher');
  var iosInitialize = const IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  var platformInitialize = InitializationSettings(
    android: androidInitialize,
    iOS: iosInitialize,
  );
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin.initialize(
    platformInitialize,
    onSelectNotification: (String? payload) async {
      onNotifClicked(navigatorKey, payload);
    },
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    provisional: true,
    sound: true,
  );

  await firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    executeMessage(message);
  });
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  return executeMessage(message);
}

subscribeNotif() async {
  await FirebaseMessaging.instance.subscribeToTopic('tesnotif');
}

unsubscribeNotifNew() async {
  await FirebaseMessaging.instance.unsubscribeFromTopic('tesnotif');
}

executeMessage(RemoteMessage? message) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  var androidDetail = const AndroidNotificationDetails(
    'hayyudoc_channel',
    'HayyuDOC Channel',
    priority: Priority.high,
    importance: Importance.max,
    styleInformation: DefaultStyleInformation(true, true),
    playSound: true,
    visibility: NotificationVisibility.public,
  );

  var iosDetail = const IOSNotificationDetails(
    presentSound: true,
    presentAlert: true,
    presentBadge: true,
  );

  var notifDetail = NotificationDetails(android: androidDetail, iOS: iosDetail);

  RemoteNotification? notification = message?.notification;
  AndroidNotification? android = message?.notification?.android;

  String? dataJson = jsonEncode(message?.data);

  if (notification != null && android != null) {
    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notifDetail,
      payload: dataJson,
    );
  }
}

Future onNotifClicked(navigatorKey, String? dataJson) async {
  var data = jsonDecode(dataJson ?? '');
  String from = data['from'];

  // switch (from.toLowerCase()) {
  //   case 'promosi':
  //     nextPage(
  //       navigatorKey.currentContext,
  //       DetailPromotion(idPromo: data['id_promosi']),
  //     );
  //     break;
  //   default:
  //     homeScreenPassing(navigatorKey.currentContext);
  // }
}
