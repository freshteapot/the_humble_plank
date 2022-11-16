import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/theme.dart';
import 'package:thehumbleplank/utils.dart';

ButtonStyle _cancelActionButtonStyle() {
  return primaryButtonStyle().copyWith(
    foregroundColor: MaterialStateProperty.all(Colors.red),
    side: MaterialStateProperty.all<BorderSide>(
        BorderSide(color: Colors.red, width: 1)),
  );
}

ButtonStyle _doActionButtonStyle() {
  return primaryButtonStyle().copyWith(
    foregroundColor: MaterialStateProperty.all(Colors.green),
    side: MaterialStateProperty.all<BorderSide>(
        BorderSide(color: Colors.green, width: 1)),
  );
}

Future<String> notifyMeBecauseICreatedAChallenge(BuildContext context) async {
  final String title = "Challenge setup";
  final String content =
      "Would you like to enable notifications, to be notified when a plank is added to your challenge?";

  String pressed = "-1";
  // set up the buttons
  Widget noButton = TextButton(
    child: Text("Not now"),
    style: _cancelActionButtonStyle(),
    onPressed: () async {
      await context
          .read<PlankModel>()
          .setShownChallengeNotification("onCreate", true);
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Yes"),
    style: _doActionButtonStyle(),
    onPressed: () async {
      await context
          .read<PlankModel>()
          .setShownChallengeNotification("onCreate", true);
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
    style: _cancelActionButtonStyle(),
    onPressed: () async {
      await context
          .read<PlankModel>()
          .setShownChallengeNotification("onJoin", true);
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Yes"),
    style: _doActionButtonStyle(),
    onPressed: () async {
      await context
          .read<PlankModel>()
          .setShownChallengeNotification("onJoin", true);
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
    style: _cancelActionButtonStyle(),
    onPressed: () async {
      await context
          .read<PlankModel>()
          .setShownChallengeNotification("onPlank", true);
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Yes"),
    style: _doActionButtonStyle(),
    onPressed: () async {
      await context
          .read<PlankModel>()
          .setShownChallengeNotification("onPlank", true);
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
    style: _cancelActionButtonStyle(),
    onPressed: () async {
      await context
          .read<PlankModel>()
          .setShownChallengeNotification("withChallenges", true);
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Yes"),
    style: _doActionButtonStyle(),
    onPressed: () async {
      await context
          .read<PlankModel>()
          .setShownChallengeNotification("withChallenges", true);
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
    style: _cancelActionButtonStyle(),
    onPressed: () async {
      Navigator.of(context).pop();
      pressed = "0";
    },
  );

  Widget yesButton = TextButton(
    child: Text("Enable"),
    style: _doActionButtonStyle(),
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
