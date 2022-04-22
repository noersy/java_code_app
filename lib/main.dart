import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/providers/auth_providers.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/providers/location_provider.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/singletons/shared_preferences.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/view/auth/findlocation_page.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:java_code_app/widget/firebase_config.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:device_preview/device_preview.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
  playSound: true,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      executeMessage(message);
    }
  });

  Logger.root.level = Level.OFF;
  if (kDebugMode) Logger.root.level = Level.ALL;
  final _log = Logger('Main');

  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  runZonedGuarded(() {
    runApp(
      DevicePreview(
        enabled: false,
        builder: (_) => const MyApp(),
      ),
    );
  }, (error, stackTrace) {
    _log.warning(error);
    _log.warning(stackTrace);
  }, zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String message) {
    _log.info(message);
    // parent.print(zone, "a message");
  }));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> msgKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ConnectionStatus.getInstance().initialize(navigatorKey);
    // GeolocationStatus.getInstance().initialize();
    Preferences.getInstance().initialize();
    UserInstance.getInstance().initialize();
    // PushNotification.getInstance().initialize();
    setHttpOverrides();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OrderProviders(),
        ),
        ChangeNotifierProvider(
          create: (_) => LangProviders(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProviders(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
      ],
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          title: 'Java Code App',
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: msgKey,
          routes: {"/dashboard": (_) => const DashboardPage()},
          theme: ThemeData.light().copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: ColorSty.primary,
                ),
          ),
          home: const FindLocationPage(),
        ),
      ),
    );
  }

  setHttpOverrides() {
    if (kDebugMode) HttpOverrides.global = MyHttpOverrides();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
