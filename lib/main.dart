import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/providers/auth_providers.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/singletons/check_connectivity.dart';
import 'package:java_code_app/singletons/check_location.dart';
import 'package:java_code_app/singletons/fcm.dart';
import 'package:java_code_app/singletons/shared_preferences.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/view/auth/login_page.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  Logger.root.level = Level.OFF;
  if (kDebugMode) Logger.root.level = Level.ALL;
  final _log = Logger('Main');

  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  runZonedGuarded(() {
    runApp(    DevicePreview(
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
final GlobalKey<ScaffoldMessengerState> msgKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectionStatus.getInstance().initialize(navigatorKey);
    GeolocationStatus.getInstance().initialize();
    Preferences.getInstance().initialize();
    UserInstance.getInstance().initialize();
    PushNotification.getInstance().initialize();

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
          home: const LoginPage(),
        ),
      ),
    );
  }
}
