import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:openapi/api.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';

import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/widget/challenge_menu.dart';
import 'package:thehumbleplank/widget/plank_screen_call_to_action.dart';

class PlankScreen extends StatefulWidget {
  int intervalTime;
  bool showIntervals;
  Challenge currentChallenge;
  List<Challenge> challenges;

  PlankScreen(
      {Key key,
      this.intervalTime: 0,
      this.showIntervals: false,
      this.currentChallenge,
      this.challenges})
      : super(key: key);

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
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasChallenge = widget.currentChallenge.uuid != "";

    double historyHeight = MediaQuery.of(context).size.height / 1.5;
    bool showChallenges = widget.challenges.length > 0;
    //bool showChallenge = widget.currentChallenge.uuid != "";

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
                                    child: GestureDetector(
                                        onTap: () async {
                                          await showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return WillPopScope(
                                                    onWillPop: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      return false;
                                                    },
                                                    child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            2.0,
                                                        child: plankScreenCallToAction(
                                                            context,
                                                            widget
                                                                .currentChallenge)));
                                              });
                                        },
                                        child: Text(
                                          widget.currentChallenge.description,
                                          style: TextStyle(color: Colors.black),
                                        )))),
                          ),
                        ],
                      ],
                    ),
                  )),
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
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.0,
                                      child: _challengesView(
                                          context, widget.challenges)));
                            });
                        //
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
      state = "plank_summary";
    });

    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  Future<void> onTimerSave(BuildContext context) async {
    // TODO save to local storage first
    await context.read<PlankModel>().addEntry(record);
    record = defaultPlank(widget.showIntervals, widget.intervalTime);
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    beginningTime = null;
    currentTime = null;

    setState(() {
      state = "plank_start";
    });
  }

  Future<void> onTimerReset(BuildContext context) async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);

    record = defaultPlank(widget.showIntervals, widget.intervalTime);

    beginningTime = null;
    currentTime = null;

    context.read<PlankModel>().setChallenge(Challenge.empty());

    setState(() {
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
      child: FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
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
      child: FlatButton(
        color: Colors.red,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.redAccent,
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
      child: FlatButton(
        color: Colors.red,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.redAccent,
        onPressed: () {
          onReset(context);
        },
        child: Text(
          'Discard',
          style: TextStyle(fontSize: 20.0),
        ),
      ));

  Widget save = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FlatButton(
        color: Colors.green,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.greenAccent,
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

Widget _challengesView(BuildContext context, List<Challenge> challenges) {
  List<ChallengeMenu> items = List<ChallengeMenu>();
  items.add(ChallengeMenu(name: "No challenge", type: 1));
  items.addAll(challenges.map((challenge) {
    return ChallengeMenu(name: challenge.description, type: 2, data: challenge);
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

                          if (item.type == 1) {
                            await context
                                .read<PlankModel>()
                                .setChallenge(Challenge.empty());
                            Navigator.pop(context);
                            return;
                          }

                          // Assumed 2
                          Challenge newChallenge = item.data as Challenge;
                          await context
                              .read<PlankModel>()
                              .getChallengeWithHistory(newChallenge.uuid);
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
