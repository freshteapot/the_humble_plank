import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/theme.dart';
import 'package:thehumbleplank/widget/notify_me.dart';

class ChallengeCreateScreen extends StatelessWidget {
  final Challenge challenge = Challenge.empty();
  final _defaultTitle = "Plank off ${Jiffy().format("EEEE do MMMM")}";
  ChallengeCreateScreen();

  @override
  Widget build(BuildContext context) {
    bool challengeNotificationShownOnCreate = context
        .select((PlankModel model) => model.challengeNotificationShownOnCreate);

    bool appPushNotifications =
        context.select((PlankModel model) => model.appPushNotifications);

    bool showNotificationNag =
        !appPushNotifications && !challengeNotificationShownOnCreate;

    return Column(children: <Widget>[
      Container(
          alignment: Alignment.bottomCenter,
          child: Column(children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Description',
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 2.0),
                ),
              ),
            ),
            TextField(
              onChanged: (String newValue) {
                challenge.description = newValue;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: _defaultTitle),
            ),
          ])),
      Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(vertical: 50),
          child: TextButton(
            style: primaryButtonStyle(),
            onPressed: () async {
              if (challenge.description.isEmpty) {
                challenge.description = _defaultTitle;
              }

              // TODO we do not handle if it fails
              await context.read<PlankModel>().addChallenge(context, challenge);
              if (showNotificationNag) {
                await notifyMeBecauseICreatedAChallenge(context);
              }

              Navigator.of(context).pop();
            },
            child: Text(
              "Create a new challenge",
              style: TextStyle(fontSize: 20.0),
            ),
          ))
    ]);
  }
}
