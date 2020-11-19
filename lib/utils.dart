/*// utility functions used in the project
// prepend a zero to integers smaller than 10 (used for the second and minute values)
function zeroPadded(number) {
    return number >= 10 ? number.toString() : `0${number}`;
}
// consider the last digit of the input number (used for the tenths of seconds)
function lastDigit(number) {
    return number.toString()[number.toString().length - 1];
}

/* format time in the following format
mm:ss:t
zero padded minutes, zero padded seconds, tenths of seconds
*/
export function formatTime(milliseconds) {
    const mm = zeroPadded(Math.floor(milliseconds / 1000 / 60));
    const ss = zeroPadded(Math.floor(milliseconds / 1000) % 60);
    const t = lastDigit(Math.floor(milliseconds / 100));
    return `${mm}:${ss}.${t}`;
}
*/

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thehumbleplank/plank_model.dart';

import 'notifications.dart';

String _zeroPadded(int number) {
  // Maybe pad left
  return number >= 10 ? number.toString() : "0$number";
}

String _lastDigit(number) {
  return number.toString()[number.toString().length - 1];
}

String formatTime(int milliseconds) {
  var mm = _zeroPadded((milliseconds / 1000 / 60).floor());
  var ss = _zeroPadded((milliseconds / 1000 % 60).floor());
  var t = _lastDigit((milliseconds / 100).floor());
  return "$mm:$ss.$t";
}

Future<void> checkAndAskForNotificationPermission(BuildContext context) async {
  PermissionStatus permission = await PermissionHandler()
      .checkPermissionStatus(PermissionGroup.notification);
  if (permission != PermissionStatus.granted) {
    if (permission == PermissionStatus.unknown) {
      var settings = await requestPermission();
      bool newState =
          settings.authorizationStatus == AuthorizationStatus.authorized
              ? true
              : false;
      await context.read<PlankModel>().setPushNotifications(newState);
    }

    // TODO This is where we could nag the user should we want to, to enable notifications
  }
}
