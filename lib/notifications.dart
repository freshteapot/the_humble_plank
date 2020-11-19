// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:thehumbleplank/plank_model.dart';

class MessageArguments {
  /// The RemoteMessage
  final RemoteMessage message;

  /// Whether this message caused the application to open.
  final bool openedApplication;

  // ignore: public_member_api_docs
  MessageArguments(this.message, this.openedApplication)
      : assert(message != null);
}

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // I wonder if I need this for push notifications?
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
  enableVibration: true,
  playSound: true,
);

/// Initalize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupNotifications(
    BuildContext context, PlankModel plankModel) async {
  //WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );

  // We might not want to use both
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;

    // Handle when  the notification is challenge:updated
    // Get challenge
    // Set challenge
    // Update index for the screen
    // await plankModel.notificationChallengeUpdated(challengeUUID)

    // With the above settings set so the popup doesnt appear,
    // It would be possible to set the "history notification"
    var data = message.data;
    if (data["action"] == "challenge:updated") {
      plankModel.setNewHistory();
    }

    if (data["action"] == "challenge:joined") {
      String who = data["who"];
      String name = data["name"];
      String challengeUUID = data["uuid"];
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        //title: "Loading...",
        message: "$who has joined $name",
        duration: Duration(seconds: 5),
        blockBackgroundInteraction: true,
        onTap: (flushbar) async {
          print("Lookup $challengeUUID and then goto challenege page");
          await plankModel.notificationChallengeUpdated(
              message.messageId, challengeUUID);
          flushbar.dismiss(true);
        },
      )..show(context);
    }

    if (notification != null && android != null) {
      // TODO make sure I am happy with android
      /*
      await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ));
      */
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print('A new onMessageOpenedApp event was published!');
    print(message);
    var data = message.data;
    if (data["action"] == "challenge:record" ||
        data["action"] == "challenge:joined") {
      String challengeUUID = data["uuid"];
      await plankModel.notificationChallengeUpdated(
          message.messageId, challengeUUID);
      return;
    }
  });

  // How to redirect on load
  // This fires if we open it from the notification center.
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage message) async {
    if (message != null) {
      print("getInitialMessage $message");
      print("after");

      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        title: "Loading...",
        message: "Something...",
        duration: Duration(seconds: 5),
        blockBackgroundInteraction: true,
      )..show(context);

      var data = message.data;
      if (data["action"] == "challenge:record" ||
          data["action"] == "challenge:joined") {
        String challengeUUID = data["uuid"];
        print("Lookup $challengeUUID and then goto challenege page");
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.GROUNDED,
          title: "Loading...",
          message: "Lookup $challengeUUID and then goto challenege page",
          duration: Duration(seconds: 5),
          blockBackgroundInteraction: true,
        )..show(context);

        await plankModel.notificationChallengeUpdated(
            message.messageId, challengeUUID);
        return;
      }
    }
  });

  // Send this with the userID back to the server
  String token = await FirebaseMessaging.instance.getToken();
  print("FCM token $token");
  await plankModel.sendTokenToServer(token);
}

Future<NotificationSettings> requestPermission() {
  return FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    // This will ensure the popup shows for users
    provisional: false,
  );
}
