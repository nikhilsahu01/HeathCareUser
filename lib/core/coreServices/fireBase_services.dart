import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../screens/services/my_health_record/view/my_health_records_screen.dart';
class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _isInitialized = false;
  late BuildContext context;

  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    // context = passedContext;

    try {
      // 🔔 Request Firebase Notification Permission
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        print('⚠️ Notification permission not granted');
        return;
      }

      // ✅ Get FCM Token and store
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("deviceToken", token);
        print("📲 FCM Token: $token");
      }

      // 🎯 Foreground Notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("📩 Foreground Notification Received: ${message.notification?.title}");
        // Provider.of<NewOrderViewModel>(context, listen: false).fetchNewOrders();
        if (message.notification != null) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
              channelKey: 'basic_channel',
              title: message.notification?.title,
              body: message.notification?.body,
              notificationLayout: NotificationLayout.BigPicture,
              bigPicture: message.notification?.android?.imageUrl ?? message.data['image'],
              payload: {'screen': 'home'},
            ),
          );
        }
      });

      // 🟡 Background / Terminated → App Opened
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("📲 App opened via notification: ${message.data}");
        
        // Convert Map<String, dynamic> to Map<String, String?>
        final convertedData = message.data.map((key, value) => MapEntry(key, value?.toString()));
        handleNotificationNavigation(convertedData, context);
      });
      AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction action) async {
          await handleNotificationAction(action, context);
        },
      );


    } catch (e) {
      print("❌ Firebase Notification Init Error: $e");
    }
  }
  Future<void> handleNotificationAction(ReceivedAction action, BuildContext context) async {
    if (action.payload != null) {
      handleNotificationNavigation(action.payload!, context);
    }
  }

  void handleNotificationNavigation(Map<String, String?> data, BuildContext context) {
    if (data['screen'] == 'prescription') {
      // Navigate to My Health Records
      // We assume there's a GlobalKey<NavigatorState> in main.dart
      // E.g. MyApp.navigatorKey.currentState?.push(...)
      try {
        final context = MyApp.navigatorKey.currentContext;
        if (context != null) {
           Navigator.push(context, MaterialPageRoute(builder: (_) => const MyHealthAndRecords()));
        }
      } catch (e) {
        print("Navigation Error: $e");
      }
    }
  }

}
