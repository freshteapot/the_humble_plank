import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import 'package:the_humble_plank/plank_model.dart';
import 'package:the_humble_plank/utils.dart';
import 'package:the_humble_plank/learnalist/challenge.dart';
import 'package:the_humble_plank/widget/onshare.dart';

class PlankChallengeHistory extends StatelessWidget {
  final VoidCallback onPlank;
  final VoidCallback onLeave;
  PlankChallengeHistory({
    this.onPlank,
    this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    Challenge challenge = context.watch<PlankModel>().challenge;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Align(
            alignment: Alignment.topCenter,
            child: RefreshIndicator(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      challenge.description,
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 2.0),
                    ),
                    menuRow(context, challenge),
                    _dataTableViaFutureBuilder(context, challenge)
                  ],
                ),
                onRefresh: () {
                  print("Refresh challenge");
                  // TODO this is not refreshing today.
                  return;
                })));
  }

  Widget menuRow(BuildContext context, Challenge challenge) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SizedBox(
          width: 60, // specific value
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.history,
                  size: 18,
                ),
                Text("History"),
              ],
            ),
            onPressed: () async {
              await context
                  .read<PlankModel>()
                  .getChallengeWithHistory(challenge.uuid);
            },
          )),
      SizedBox(
          width: 60, // specific value
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.timer, size: 18),
                Text("plank"),
              ],
            ),
            onPressed: () {
              context.read<PlankModel>().setChallenge(challenge);
              onPlank();
            },
          )),
      SizedBox(
          width: 60, // specific value
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.share, size: 18),
                Text("Share"),
              ],
            ),
            onPressed: () {
              shareChallenge(context, challenge);
            },
          )),
      SizedBox(
          width: 60, // specific value
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.close, size: 18),
                Text("Leave"),
              ],
            ),
            onPressed: () async {
              await context.read<PlankModel>().leaveChallenge(challenge.uuid);
              onLeave();
            },
          )),
    ]);
  }

  Widget _dataTableViaFutureBuilder(BuildContext context, Challenge challenge) {
    Map<String, String> users = new Map<String, String>();
    challenge.users.forEach((user) {
      users[user.userUuid] = user.name;
    });

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Duration',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'When',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Who',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: challenge.records.map((record) {
              var when =
                  DateTime.fromMillisecondsSinceEpoch(record.beginningTime);

              return DataRow(cells: <DataCell>[
                DataCell(Text(formatTime(record.timerNow))),
                DataCell(
                  Text(Jiffy(when).fromNow()),
                ),
                DataCell(Text(users[record.userUuid])),
              ]);
            }).toList()));
  }
}
