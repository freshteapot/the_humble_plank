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
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// I wonder if I need this for push notifications?
// TODO seems broken for now
// https://github.com/FirebaseExtended/flutterfire/issues/4198
// https://github.com/FirebaseExtended/flutterfire/issues/4185
//  await Firebase.initializeApp();
//   print("Handling a background message ${message.messageId}");
// }

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
  await Firebase.initializeApp();

  // TODO not sure how I want to use this yet
  // Set the background messaging handler early on, as a named top-level function
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
    // With the above settings set so the popup doesnt appear,
    // It would be possible to set the "history notification"
    // Hmm what is this?
    var data = message.data;
    if (data["action"] == "challenge.newrecord" ||
        data["action"] == "challenge.joined" ||
        data["action"] == "challenge.left") {
      String challengeUUID = data["uuid"];
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        message: message.notification.body,
        duration: Duration(seconds: 5),
        blockBackgroundInteraction: true,
        onTap: (flushbar) async {
          await plankModel.notificationChallengeUpdated(
              message.messageId, challengeUUID);
          flushbar.dismiss(true);
        },
      )..show(context);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    var data = message.data;
    if (data["action"] == "challenge.newrecord" ||
        data["action"] == "challenge.joined") {
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
      var data = message.data;
      if (data["action"] == "challenge.newrecord" ||
          data["action"] == "challenge.joined" ||
          data["action"] == "challenge.left") {
        String challengeUUID = data["uuid"];
        await plankModel.notificationChallengeUpdated(
            message.messageId, challengeUUID);
        return;
      }
    }
  });

  // Send this with the userID back to the server
  String token = await FirebaseMessaging.instance.getToken();
  await plankModel.sendTokenToServer(token);
}

Future<NotificationSettings> getNotificationSettings() {
  return FirebaseMessaging.instance.getNotificationSettings();
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

Future<String> getToken() {
  return FirebaseMessaging.instance.getToken();
}
