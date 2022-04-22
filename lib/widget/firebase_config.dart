import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:java_code_app/constans/key_prefens.dart';
import 'package:java_code_app/singletons/shared_preferences.dart';
import 'package:http/http.dart' as http;

final navigatorKey = GlobalKey<NavigatorState>();

firebaseConfiguration() async {
  await FirebaseMessaging.instance.getToken();
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

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    executeMessage(message);
  });
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  return executeMessage(message);
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

subscribeNotif() async {
  int userId = await Preferences.getInstance().getIntValue(KeyPrefens.loginID);
  await FirebaseMessaging.instance.subscribeToTopic('javacode-$userId');
}

unsubscribeNotif() async {
  int userId = await Preferences.getInstance().getIntValue(KeyPrefens.loginID);
  await FirebaseMessaging.instance.unsubscribeFromTopic('javacode-$userId');
}

sendPushNotif() async {
  var response = await http
      .post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAp-W2BeM:APA91bE4QoNtgWn-LiL38O6d56JUHb_od_FvMteU1x6GtZBbwMF7bU7OcCUyC_rOg1l8VkuvSj6EZ_ZA61LCYDAFfiAg3jMKXnMaDZbARuqqXqyphRdTogJViIIouTLck_85Oyb6U-aY',
          },
          body: jsonEncode({
            'to': '/topics/javacode-1',
            'notification': <String, dynamic>{
              'title': 'tes notif',
              'body': {
                'to': 'order',
                'lala': 100,
              },
              'sound': 'true'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'title': 'tes notif',
            },
          }))
      .catchError((e) {
    var tes = e;
  });
  return response;
}
