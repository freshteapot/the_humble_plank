import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import 'package:openapi/api.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/notifications.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/utils.dart';
import 'package:thehumbleplank/widget/bottombar.dart';
import 'package:thehumbleplank/widget/challenge_history.dart';
import 'package:thehumbleplank/widget/topbar.dart';

class HistoryMenu {
  String name;
  int type;
  dynamic data;

  HistoryMenu({this.name, this.type, this.data});
}

class PlankHistoryScreen2 extends StatefulWidget {
  List<Plank> history;
  List<Challenge> challenges;
  Challenge currentChallenge;
  PlankHistoryScreen2({
    this.history,
    this.challenges,
    this.currentChallenge,
  });

  @override
  _PlankHistoryScreenState createState() => _PlankHistoryScreenState();
}

class _PlankHistoryScreenState extends State<PlankHistoryScreen2> {
  @override
  Widget build(BuildContext context) {
    final MessageArguments args = ModalRoute.of(context).settings.arguments;
    print("MessageArguments $args");
    widget.currentChallenge =
        context.select((PlankModel model) => model.challenge);
    widget.challenges = context.select((PlankModel model) => model.challenges);
    widget.history = context.select((PlankModel model) => model.history);

    Widget historyView;
    double historyHeight = MediaQuery.of(context).size.height / 1.3;
    bool showChallenges = widget.challenges.length > 0;
    bool showChallenge = widget.currentChallenge.uuid != "";

    if (showChallenges) {
      historyHeight = MediaQuery.of(context).size.height / 1.5;
    }

    if (showChallenge) {
      historyView = RefreshIndicator(
          child: challengeHistoryDataView(context, widget.currentChallenge),
          onRefresh: () async {
            await context
                .read<PlankModel>()
                .getChallengeWithHistory(widget.currentChallenge.uuid);
          });
    } else {
      historyView = RefreshIndicator(
          child: _dataTableViaFutureBuilder(context, widget.history),
          onRefresh: () {
            return context.read<PlankModel>().loadHistory();
          });
    }

    Widget bottomNav = bottomBar((newIndex) {
      if (newIndex == 0) {
        // Maybe reload challenge history or my history
        return;
      }
      if (newIndex == 1) {
        Navigator.popAndPushNamed(context, '/plank/timer');
        return;
      }
    }, 0, false);

    return Scaffold(
        appBar: topBar(),
        backgroundColor: Colors.white,
        bottomNavigationBar: bottomNav,
        body: Align(
            alignment: Alignment.topCenter,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: historyHeight,
                    alignment: Alignment.topCenter,
                    child: historyView,
                  ),
                  if (showChallenges) ...[
                    Container(
                        alignment: Alignment.center,
                        child: FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () async {
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.0,
                                          child: _challengesView(
                                              context, widget.challenges)));
                                });
                            //
                          },
                          child: Text(
                            "Change",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ))
                  ],
                ])));
  }
}

Widget _dataTableViaFutureBuilder(BuildContext context, List<Plank> records) {
  DateTime streak = DateTime.now().toUtc();

  return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Day',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
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
          ],
          rows: records.map((record) {
            var when =
                DateTime.fromMillisecondsSinceEpoch(record.beginningTime);

            var a = Jiffy(streak).endOf(Units.DAY);
            var b = Jiffy(when).endOf(Units.DAY);
            var diff = a.difference(b);

            var showStreak = false;
            if (diff <= Duration(hours: 24)) {
              streak = when;
              showStreak = true;
            }

            return DataRow(cells: <DataCell>[
              _dayCell(record, showStreak),
              DataCell(Text(formatTime(record.timerNow))),
              DataCell(
                Text(DateFormat("HH:mm:ss").format(
                    DateTime.fromMillisecondsSinceEpoch(record.beginningTime))),
              ),
            ]);
          }).toList()));
}

DataCell _dayCell(record, showStreak) {
  List<Widget> day = [];
  if (showStreak) {
    day.add(_streakIndicator());
  }

  day.add(
    Text(DateFormat("yyy-MM-dd")
        .format(DateTime.fromMillisecondsSinceEpoch(record.beginningTime))),
  );
  return DataCell(
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: day));
}

Widget _streakIndicator() {
  return CircleAvatar(
    backgroundColor: Colors.green,
    radius: 5.0,
  );
}

Widget _challengesView(BuildContext context, List<Challenge> challenges) {
  List<HistoryMenu> items = List<HistoryMenu>();
  items.add(HistoryMenu(name: "All my planks", type: 1));
  items.addAll(challenges.map((challenge) {
    return HistoryMenu(name: challenge.description, type: 2, data: challenge);
  }).toList());

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
                // A fixed-height child.
                //height: MediaQuery.of(context).size.height / 0.5,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: const Text('Pick from'),
              ),
              Expanded(
                // A flexible child that will grow to fit the viewport but
                // still be at least as big as necessary to fit its contents.
                child: Container(
                  height: 120.0,
                  alignment: Alignment.center,
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('${items[index].name}'),
                        onTap: () async {
                          var item = items[index];
                          var newChallenge = Challenge.empty();
                          if (item.type == 2) {
                            newChallenge = item.data as Challenge;
                            await context
                                .read<PlankModel>()
                                .getChallengeWithHistory(newChallenge.uuid);
                          } else {
                            await context
                                .read<PlankModel>()
                                .setChallenge(newChallenge);
                          }

                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}
