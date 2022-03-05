import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thehumbleplank/theme.dart';
import 'package:thehumbleplank/widget/notify_me.dart';
import 'package:thehumbleplank/widget/plank_pick_challenge.dart';
import 'package:wakelock/wakelock.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:openapi/api.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/widget/challenge_menu.dart';

class PlankScreen extends StatefulWidget {
  int intervalTime;
  bool showIntervals;
  List<Challenge> challenges;
  Challenge currentChallenge;
  String currentChallengeUUID;
  String previousChallengeUUID;

  bool showNotificationNagOnPlank;
  // TODO add

  PlankScreen({
    Key key,
    this.intervalTime: 0,
    this.showIntervals: false,
    this.challenges,
    this.currentChallenge,
    this.currentChallengeUUID,
    this.previousChallengeUUID,
    this.showNotificationNagOnPlank: false,
  }) : super(key: key);

  @override
  _PlankScreenState createState() => _PlankScreenState();
}

class _PlankScreenState extends State<PlankScreen> {
  final _isHours = false;
  final _isMilliSecond = true;
  int beginningTimeInterval = 0;
  DateTime beginningTime;
  DateTime currentTime;
  Plank record = Plank();
  String state = "";

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
  );

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) => _onChange(value));
    record = defaultPlank(widget.showIntervals, widget.intervalTime);
    Wakelock.disable();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
    Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    bool hasChallenge = widget.currentChallenge.uuid != "";

    double historyHeight = MediaQuery.of(context).size.height / 1.5;
    bool showChallenges = widget.challenges.length > 0;

    return Align(
        alignment: Alignment.topCenter,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  height: historyHeight,
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        /// Display stop watch time
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: StreamBuilder<int>(
                            stream: _stopWatchTimer.rawTime,
                            initialData: 0,
                            builder: (context, snap) {
                              int value = 0;
                              if (record.beginningTime != null) {
                                value = record.timerNow;
                              }

                              final displayTime = StopWatchTimer.getDisplayTime(
                                  value,
                                  milliSecond: _isMilliSecond,
                                  hours: _isHours);
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      displayTime,
                                      style: const TextStyle(
                                          fontSize: 40,
                                          fontFamily: 'Helvetica',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        ...(record.showIntervals
                            ? extra(_stopWatchTimer, record)
                            : <Widget>[]),

                        menu(context, state, onTimerStart, onTimerStop,
                            onTimerSave, onTimerReset),

                        if (hasChallenge) ...[
                          Dismissible(
                              // Each Dismissible must contain a Key. Keys allow Flutter to
                              // uniquely identify widgets.
                              key: Key("fake"),
                              // Provide a function that tells the app
                              // what to do after an item has been swiped away.
                              onDismissed: (direction) {
                                // Remove the item from the data source.
                                context
                                    .read<PlankModel>()
                                    .setChallenge(Challenge.empty());
                              },
                              direction: DismissDirection.endToStart,
                              background: Container(color: Colors.red),
                              child: ListTile(
                                  title: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.currentChallenge.description,
                                        style: TextStyle(color: Colors.black),
                                      )))),
                        ],
                      ],
                    ),
                  )),
              if (showChallenges) ...[
                Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      style: primaryButtonStyle(),
                      onPressed: () async {
                        await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.0,
                                  //child: _challengesView(
                                  //    context, widget.challenges));

                                  child: PlankPickChallenge(
                                    challenges: widget.challenges,
                                    currentChallengeUUID:
                                        widget.currentChallengeUUID,
                                    previousChallengeUUID:
                                        widget.previousChallengeUUID,
                                    onTap: (ChallengeMenu item) async {
                                      if (item.type == 1) {
                                        await context
                                            .read<PlankModel>()
                                            .setChallenge(Challenge.empty());
                                        Navigator.pop(context);
                                        return;
                                      }

                                      // Assumed 2
                                      Challenge newChallenge =
                                          item.data as Challenge;
                                      await context
                                          .read<PlankModel>()
                                          .getChallengeWithHistory(
                                              newChallenge.uuid);
                                      Navigator.pop(context);
                                    },
                                  ));
                            });
                      },
                      child: Text(
                        "Pick a Challenge",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ))
              ]
            ]));
  }

  void onTimerStart() {
    setState(() {
      Wakelock.enable();
      state = "plank_active";
    });

    record = defaultPlank(widget.showIntervals, widget.intervalTime);
    beginningTime = new DateTime.now();
    record.beginningTime = beginningTime.millisecondsSinceEpoch;
    record.currentTime = record.beginningTime;

    beginningTimeInterval = beginningTime.millisecondsSinceEpoch;
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void onTimerStop() {
    setState(() {
      Wakelock.disable();
      state = "plank_summary";
    });

    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  Future<void> onTimerSave(BuildContext context) async {
    // TODO what if this fails?
    // TODO save to local storage first

    await context.read<PlankModel>().addEntry(record);

    if (widget.currentChallenge.uuid != "" &&
        widget.showNotificationNagOnPlank) {
      await notifyMeBecauseIHaveAddedToAChallenge(context);
    }

    record = defaultPlank(widget.showIntervals, widget.intervalTime);
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    beginningTime = null;
    currentTime = null;

    setState(() {
      Wakelock.disable();
      state = "plank_start";
    });
  }

  Future<void> onTimerReset(BuildContext context) async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);

    record = defaultPlank(widget.showIntervals, widget.intervalTime);

    beginningTime = null;
    currentTime = null;

    setState(() {
      Wakelock.disable();
      state = "plank_start";
    });
  }

  void _onChange(int value) {
    if (beginningTime == null) {
      return;
    }

    var currentTime = DateTime.now();

    record.timerNow = currentTime.millisecondsSinceEpoch -
        beginningTime.millisecondsSinceEpoch;
    // TODO possible bug here, in reporting "currentTime"
    // Back to the server
    if (record.showIntervals) {
      if (record.intervalTimerNow > record.intervalTime * 1000) {
        DateTime intervalBeginning = DateTime.now();
        beginningTimeInterval = intervalBeginning.millisecondsSinceEpoch;
        record.intervalTimerNow = 0;
        record.laps++;
      } else {
        record.intervalTimerNow =
            currentTime.millisecondsSinceEpoch - beginningTimeInterval;
      }
    }
  }
}

List<Widget> extra(StopWatchTimer _stopWatchTimer, Plank record) {
  bool _isMilliSecond = true;
  bool _isHours = false;

  return <Widget>[
    Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Text(
          'Show interval timer ${record.intervalTime}',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Helvetica',
          ),
        )),

    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: StreamBuilder<int>(
        stream: _stopWatchTimer.rawTime,
        initialData: _stopWatchTimer.rawTime.value,
        builder: (context, snap) {
          return Column(children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text('${record.laps} lap(s)',
                    style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'Helvetica',
                    )))
          ]);
        },
      ),
    ),

    /// Display interval time.
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: StreamBuilder<int>(
        stream: _stopWatchTimer.rawTime,
        initialData: 0,
        builder: (context, snap) {
          int value = 0;
          if (record.beginningTime != null) {
            value = record.intervalTimerNow;
          }

          final displayTime = StopWatchTimer.getDisplayTime(value,
              milliSecond: _isMilliSecond, hours: _isHours);

          return Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          displayTime,
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Helvetica',
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          );
        },
      ),
    ),
  ];
}

Plank defaultPlank(bool showIntervals, int intervalTime) {
  var record = Plank();
  record.beginningTime = 0;
  record.currentTime = 0;
  record.timerNow = 0;
  record.intervalTimerNow = 0;
  record.showIntervals = showIntervals;
  record.intervalTime = showIntervals ? intervalTime : 0;
  record.laps = 0;
  return record;
}

Widget menu(BuildContext context, String state, Function onStart,
    Function onStop, Function onSave, Function onReset) {
  Widget start = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        style: primaryButtonStyle().copyWith(
          foregroundColor: MaterialStateProperty.all(Colors.green),
          side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Colors.green, width: 1)),
        ),
        onPressed: () {
          onStart();
        },
        child: Text(
          "Start",
          style: TextStyle(fontSize: 20.0),
        ),
      ));

  Widget stop = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        style: primaryButtonStyle().copyWith(
          foregroundColor: MaterialStateProperty.all(Colors.red),
          side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Colors.red, width: 1)),
        ),
        onPressed: () {
          onStop();
        },
        child: Text(
          'Stop',
          style: TextStyle(fontSize: 20.0),
        ),
      ));

  Widget reset = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        style: primaryButtonStyle().copyWith(
          foregroundColor: MaterialStateProperty.all(Colors.red),
          side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Colors.red, width: 1)),
        ),
        onPressed: () {
          onReset(context);
        },
        child: Text(
          "Discard",
          style: TextStyle(fontSize: 20.0),
        ),
      ));

  Widget save = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        style: primaryButtonStyle().copyWith(
          foregroundColor: MaterialStateProperty.all(Colors.green),
          side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Colors.green, width: 1)),
        ),
        onPressed: () {
          onSave(context);
        },
        child: Text(
          "Save",
          style: TextStyle(fontSize: 20.0),
        ),
      ));

  if (state == "plank_active") {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[stop],
            ),
          ),
        ],
      ),
    );
  }

  if (state == "plank_summary") {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[reset, save],
            ),
          ),
        ],
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(2),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[start],
          ),
        ),
      ],
    ),
  );
}
