import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/notification_screen.dart';

class FirebaseApi {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static void handleMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        ),
      );
    });
  }

  static void setupInteractedMessage() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    String? token = await _firebaseMessaging.getToken();
    print('Token: $token');

  }
}
