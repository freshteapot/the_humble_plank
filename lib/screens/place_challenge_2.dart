import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/plank_model.dart';

class PlankChallenge2 extends StatelessWidget {
  final void Function(Challenge challenge) onCreate;
  final Challenge challenge = Challenge.empty();
  final _defaultTitle = "Plank off ${Jiffy().format("EEEE do MMMM")}";
  PlankChallenge2({
    this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return _addChallengePanel(context);
  }

  Widget _addChallengePanel(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          height: MediaQuery.of(context).size.height / 2.7,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
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
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              if (challenge.description.isEmpty) {
                challenge.description = _defaultTitle;
              }
              // TODO after add, ask for permission to send notifications.
              context.read<PlankModel>().addChallenge(context, challenge);
              onCreate(challenge);
            },
            child: Text(
              "Create a new challenge",
              style: TextStyle(fontSize: 20.0),
            ),
          ))
    ]);
  }
}
