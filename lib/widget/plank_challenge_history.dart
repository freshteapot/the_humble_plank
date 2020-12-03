import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:jiffy/jiffy.dart';

import 'package:thehumbleplank/utils.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';

Widget plankChallengeHistoryView(BuildContext context, Challenge challenge) {
  // This breaks, when I set the challenge without getting the history
  Map<String, String> users = new Map<String, String>();

  int playerIndex = 1;
  challenge.users.forEach((user) {
    String userName = user.name;
    if (user.userUuid == user.name) {
      userName = "Player $playerIndex";
      playerIndex++;
    }

    users[user.userUuid] = userName;
  });

  return ListView.separated(
    separatorBuilder: (context, index) {
      return Divider();
    },
    itemCount: challenge.records.length + 1,
    itemBuilder: (context, index) {
      // Fucking ugly
      if (index == 0) {
        return _historyListTileHeader(context);
      }

      var record = challenge.records[index - 1];
      return _historyListTile(context, record, users);
    },
  );
}

Widget _historyListTileHeader(BuildContext context) {
  TextStyle style =
      const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  return ListTile(
    title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Duration", style: style),
          Text("When", style: style),
          Text("Who", style: style),
        ]),
  );
}

Widget _historyListTile(BuildContext context, ChallengePlankRecord record,
    Map<String, String> users) {
  String duration = formatTime(record.timerNow);
  String when = Jiffy(DateTime.fromMillisecondsSinceEpoch(record.beginningTime))
      .fromNow();
  String userName = users[record.userUuid];

  return ListTile(
    title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(duration),
          Text(when),
          Text(userName),
        ]),
  );
}
