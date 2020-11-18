import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:openapi/api.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';

import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/widget/plank_screen_call_to_action.dart';

class PlankScreen extends StatefulWidget {
  final int intervalTime;
  final bool showIntervals;
  final Challenge challenge;
  PlankScreen(
      {Key key,
      this.intervalTime: 0,
      this.showIntervals: false,
      this.challenge})
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
    bool hasChallenge = widget.challenge.uuid != "";

    return Center(
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

                final displayTime = StopWatchTimer.getDisplayTime(value,
                    milliSecond: _isMilliSecond, hours: _isHours);
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

          menu(context, state, onTimerStart, onTimerStop, onTimerSave,
              onTimerReset),

          if (hasChallenge) ...[
            Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key("fake"),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                context.read<PlankModel>().setChallenge(Challenge.empty());
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
                                        Navigator.of(context).pop();
                                        return false;
                                      },
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.0,
                                          child: plankScreenCallToAction(
                                              context, widget.challenge)));
                                });
                          },
                          child: Text(
                            widget.challenge.description,
                            style: TextStyle(color: Colors.black),
                          )))),
            ),
          ],
        ],
      ),
    );
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
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    // TODO save to local storage first
    await context.read<PlankModel>().addEntry(record);
    record = defaultPlank(widget.showIntervals, widget.intervalTime);

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
