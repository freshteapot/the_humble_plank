import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import 'package:openapi/api.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/utils.dart';

Widget plankHistoryView(BuildContext context, List<Plank> records) {
  DateTime streak = DateTime.now().toUtc();

  return ListView.separated(
    separatorBuilder: (context, index) {
      return Divider();
    },
    itemCount: records.length + 1,
    itemBuilder: (context, index) {
      // Fucking ugly
      if (index == 0) {
        return _historyListTileHeader(context);
      }

      var record = records[index - 1];

      var when = DateTime.fromMillisecondsSinceEpoch(record.beginningTime);

      var a = Jiffy(streak).endOf(Units.DAY);
      var b = Jiffy(when).endOf(Units.DAY);
      var diff = a.diff(b, Units.HOUR);

      var showStreak = false;
      if (diff <= Duration(hours: 24).inHours) {
        streak = when;
        showStreak = true;
      }

      return _historyListTile(context, record, showStreak);
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
          Text("Day", style: style),
          Text("Duration", style: style),
          Text("When", style: style),
        ]),
  );
}

Widget _historyListTile(BuildContext context, Plank record, bool showStreak) {
  return ListTile(
    title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _dayWidget(record, showStreak),
          Text(formatTime(record.timerNow)),
          Text(DateFormat("HH:mm:ss").format(
              DateTime.fromMillisecondsSinceEpoch(record.beginningTime))),
        ]),
    onTap: () async {
      await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () async {
                  await context
                      .read<PlankModel>()
                      .setChallenge(Challenge.empty());
                  Navigator.of(context).pop();
                  return false;
                },
                child: Container(
                    height: MediaQuery.of(context).size.height / 2.0,
                    child: _recordOptionsPopup(context, record)));
          });
    },
  );
}

Widget _recordOptionsPopup(BuildContext context, Plank record) {
  return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: viewportConstraints.maxHeight,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: const Text('Things todo'),
              ),
              Expanded(
                // A flexible child that will grow to fit the viewport but
                // still be at least as big as necessary to fit its contents.
                child: Container(
                    height: 120.0,
                    alignment: Alignment.center,
                    child: ListView(children: <Widget>[
                      ListTile(
                        title: Text('Delete Record'),
                        trailing: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text("Are you sure?"),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlatButton(
                                        child: Text("Yes, delete",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () async {
                                          await context
                                              .read<PlankModel>()
                                              .deleteEntryFromHistory(
                                                  record.uuid);
                                          Navigator.of(context)
                                              .pop(); // Dismiss dialog
                                          Navigator.of(context)
                                              .pop(); // Second dismiss popup
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Escape"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ));
                            },
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Just close'),
                        onTap: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  });
}

Widget _dayWidget(record, showStreak) {
  List<Widget> day = [];
  if (showStreak) {
    day.add(_streakIndicator());
  }

  day.add(
    Text(DateFormat("yyy-MM-dd")
        .format(DateTime.fromMillisecondsSinceEpoch(record.beginningTime))),
  );

  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: day);
}

Widget _streakIndicator() {
  return CircleAvatar(
    backgroundColor: Colors.green,
    radius: 5.0,
  );
}
