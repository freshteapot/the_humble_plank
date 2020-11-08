import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import 'package:the_humble_plank/learnalist/challenge.dart';
import 'package:the_humble_plank/plank_model.dart';

class PlankChallenge2 extends StatelessWidget {
  final void Function(Challenge challenge) onCreate;
  final Challenge challenge = Challenge.empty();
  final _defaultTitle = "Plank off ${Jiffy().format("EEEE do MMMM")}";

  String _displayName = "";
  PlankChallenge2({
    this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    bool showCallToActionForDisplayName =
        context.watch<PlankModel>().showCallToActionForDisplayName;

    if (showCallToActionForDisplayName) {
      return _addNamePanel(context);
    }

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

  Widget _addNamePanel(BuildContext context) {
    String displayName = context.watch<PlankModel>().displayName;

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
                      'Display Name',
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 2.0),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: displayName,
                  onChanged: (String newValue) {
                    _displayName = newValue;
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
              if (_displayName.isEmpty) {
                return;
              }

              context.read<PlankModel>().setDisplayName(_displayName);
              //onCreate(challenge);
            },
            child: Text(
              "Update",
              style: TextStyle(fontSize: 20.0),
            ),
          )),
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
              context
                  .read<PlankModel>()
                  .setShowCallToActionForDisplayName(false);
              //onCreate(challenge);
            },
            child: Text(
              "Skip",
              style: TextStyle(fontSize: 20.0),
            ),
          ))
    ]);
  }
}
