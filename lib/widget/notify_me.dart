import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/utils.dart';

Future<String> notifyMeBecauseICreatedAChallenge(BuildContext context) async {
  final String title = "Challenge setup";
  final String content =
      "Would you like to enable notifications, to be notified when a plank is added to your challenge?";

  String pressed = "-1";
  // set up the buttons
  Widget noButton = TextButton(
    child: Text("Not now"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Yes"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();

      PermissionStatus permission = await Permission.notification.status;
      if (permission.isPermanentlyDenied) {
        openAppSettings();
        pressed = "1";
        return;
      }

      await Future.delayed(Duration(seconds: 1));
      await checkAndAskForNotificationPermission(context);
      pressed = "1";
    },
  );

  await _showAlertDialog(context, title, content, noButton, yesButton);
  return pressed;
}

Future<String> notifyMeBecauseIJoinedAChallenge(BuildContext context) async {
  final String title = "Challenge joined";
  final String content =
      "Would you like to enable notifications, to be notified when a plank is added to the challenge?";

  String pressed = "-1";
  // set up the buttons
  Widget noButton = TextButton(
    child: Text("Not now"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Yes"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();

      PermissionStatus permission = await Permission.notification.status;
      if (permission.isPermanentlyDenied) {
        openAppSettings();
        pressed = "1";
        return;
      }

      await Future.delayed(Duration(seconds: 1));
      await checkAndAskForNotificationPermission(context);
      pressed = "1";
    },
  );

  await _showAlertDialog(context, title, content, noButton, yesButton);
  return pressed;
}

Future<String> notifyMeBecauseIHaveAddedToAChallenge(
    BuildContext context) async {
  final String title = "Nice plank!";
  final String content =
      "Would you like to enable notifications for when your friends plank?";

  String pressed = "-1";
  // set up the buttons
  Widget noButton = TextButton(
    child: Text("Not now"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Yes"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();

      PermissionStatus permission = await Permission.notification.status;
      if (permission.isPermanentlyDenied) {
        openAppSettings();
        pressed = "1";
        return;
      }

      await Future.delayed(Duration(seconds: 1));
      await checkAndAskForNotificationPermission(context);
      pressed = "1";
    },
  );

  await _showAlertDialog(context, title, content, noButton, yesButton);
  return pressed;
}

Future<String> notifyMeBecauseIHaveChallenges(BuildContext context) async {
  final String title = "You have challenges!";
  final String content =
      "Would you like to enable notifications for when your friends plank?";
  String pressed = "-1";
  // set up the buttons
  Widget noButton = TextButton(
    child: Text("Not now"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Yes"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();

      PermissionStatus permission = await Permission.notification.status;
      if (permission.isPermanentlyDenied) {
        openAppSettings();
        pressed = "1";
        return;
      }

      await Future.delayed(Duration(seconds: 1));
      await checkAndAskForNotificationPermission(context);
      pressed = "1";
    },
  );

  await _showAlertDialog(context, title, content, noButton, yesButton);
  return pressed;
}

Future<String> notifyMeWhyEnable(BuildContext context) async {
  final String title = "Why enable notifications";
  final String content =
      "When you join a challenge, we send notifications of your friends plank.";

  String pressed = "-1";
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed: () async {
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Enable"),
    onPressed: () async {
      Navigator.of(context).pop();

      await Future.delayed(Duration(seconds: 1));
      await checkAndAskForNotificationPermission(context);
      pressed = "1";
    },
  );

  await _showAlertDialog(context, title, content, cancelButton, yesButton);
  return pressed;
}

Future<String> _showAlertDialog(BuildContext context, String title,
    String content, Widget cancelButton, Widget yesButton) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      cancelButton,
      yesButton,
    ],
  );

  // show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
