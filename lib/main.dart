import 'package:crm_new/services/cache/shared_pref_service.dart';
import 'package:crm_new/services/connection_service.dart';
import 'package:crm_new/services/notificationServices/notification.dart';
import 'package:crm_new/src/home/provider/home_provider.dart';
import 'package:crm_new/src/home/provider/project_provider.dart';
import 'package:crm_new/src/notification/providers/notification_provider.dart';
import 'package:crm_new/src/search/provider/search_provider.dart';
import 'package:crm_new/src/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:crm_new/src/login/provider/login_provider.dart';
import 'package:crm_new/theme/app_theme.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesService().setPreferences();
  PushNotificationService().setupInteractedMessage();
  ConnectionService().initLiveConnectionUpdates();
  await Permission.notification.isDenied.then(
    (bool value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
  systemUIOverlay;
  systemOrientation;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProjectProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Alpha',
          theme: lightThemeData,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
