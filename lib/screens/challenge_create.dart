import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/utils.dart';
import 'package:thehumbleplank/widget/notify_me.dart';

class ChallengeCreateScreen extends StatelessWidget {
  final Challenge challenge = Challenge.empty();
  final _defaultTitle = "Plank off ${Jiffy().format("EEEE do MMMM")}";
  ChallengeCreateScreen();

  @override
  Widget build(BuildContext context) {
    bool showChallengeNotification =
        context.select((PlankModel model) => model.showChallengeNotification);

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
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () async {
              if (challenge.description.isEmpty) {
                challenge.description = _defaultTitle;
              }

              context.read<PlankModel>().addChallenge(context, challenge);
              if (!showChallengeNotification) {
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
