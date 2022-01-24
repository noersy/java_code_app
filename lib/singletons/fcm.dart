import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
);

Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  if (notification != null && android != null) {
    _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: android.smallIcon,
          priority: Priority.high,
          // other properties...
        ),
      ),
    );
  }
}

class PushNotification {
//This creates the single instance by calling the `_internal` constructor specified below
  static final PushNotification _singleton = PushNotification._internal();

  PushNotification._internal();

  //This is what's used to retrieve the instance through the app
  static PushNotification getInstance() => _singleton;

  _initializeFirebase() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        messagingSenderId: '867038405710',
        projectId: 'javacodeapp-42f75',
        apiKey: 'AIzaSyAUXAgNYWZ8Q0ygDOejOIPtk7VF3vUWPn4',
        appId: '1:867038405710:android:000d3872ebedfb43ca0f1f',
      ),
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);


    _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_name'),
      ),
    );

    print('token: ${await FirebaseMessaging.instance.getToken()}');
  }

  static int _once = 0;

  void initialize() {
    if (_once == 0) {
      _initializeFirebase();
      FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
      FirebaseMessaging.onMessage.listen(_message);
      FirebaseMessaging.onMessageOpenedApp.listen(_messageOpen);
      _once++;
    }
  }

  void _messageOpen(RemoteMessage message) {
    print(message.notification?.title);
  }

    //foreground fcm
  void _message(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: android.smallIcon,
            // other properties...
          ),
        ),
      );
    }
  }
}
