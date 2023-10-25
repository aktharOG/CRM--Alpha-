import 'dart:convert';

import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/main.dart';
import 'package:crm_new/src/notification/notification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  //
  print("on background");
  print(message.data);

  // Handle data message
  // final data = message.data['data'];
  // print(data);

  // Or do other work.
}

class PushNotificationService {
  String title = '';
  Map<String, dynamic>? data;
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    await enableIOSNotifications();

    FirebaseMessaging.onMessage.listen((event) {
      print("object");
    });

    // Get any messages which caused the application to open from a terminated state.
    // If you want to handle a notification click when the app is terminated, you can use `getInitialMessage`
    // to get the initial message, and depending in the remoteMessage, you can decide to handle the click
    // This function can be called from anywhere in your app, there is an example in main file.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      // pushAndRemoveUntil(
      //     navigatorKey.currentState!.context,
      //     Home(
      //       from: 'noti',
      //     ));
    }
// Also handle any interaction when the app is in the background via a
    // Stream listener
    // This function is called when the app is in the background and user clicks on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("RECIEVED NEW NOTIFICATION");
  
     
        pushAndRemoveUntil(
            navigatorKey.currentState!.context, const NotificationScreen(fromNoti: true,));
      
    });

    await registerNotificationListeners();
  }

  // _handleMsg(data) {
  //   push(navigatorKey.currentState!.context, DailySuggestion());
  // }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings = const AndroidInitializationSettings(
      '@drawable/ic_notification',
    );

    var iOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        // didReceiveLocalNotificationStream.add(
        //   ReceivedNotification(
        //     id: id,
        //     title: title,
        //     body: body,
        //     payload: payload,
        //   ),4902
        // );
      },
      //notificationCategories: darwinNotificationCategories,
    );

    var initSetttings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onDidReceiveNotificationResponse: (message) async {
      // This function handles the click in the notification when the app is in foreground
      print('This is the title $title');
      pushAndRemoveUntil(
          navigatorKey.currentState!.context,
          const NotificationScreen(
            fromNoti: true,
          ));
    });

    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;

      print(notification?.title);
      title = notification!.title ?? '';
      data = message.data;
      print(notification.body);
      print(notification.android);
      print(message.data);
      print('CALLING DOT API');
      print("data : ${message.data}");

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
              playSound: true,
              largeIcon: const DrawableResourceAndroidBitmap(
                  '@drawable/ic_notification'),
              styleInformation: const BigTextStyleInformation(''),
            ),
          ),
        );
      }
    });
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  androidNotificationChannel() {
    return const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
  }
}
