import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import 'package:openapi/api.dart';
import 'package:the_humble_plank/plank_model.dart';
import 'package:the_humble_plank/utils.dart';

class PlankHistoryScreen extends StatefulWidget {
  PlankHistoryScreen();

  @override
  _PlankHistoryScreenState createState() => _PlankHistoryScreenState();
}

class _PlankHistoryScreenState extends State<PlankHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Align(
            alignment: Alignment.topCenter,
            child: RefreshIndicator(
                child: _dataTableViaFutureBuilder(context),
                onRefresh: () {
                  return context.read<PlankModel>().loadHistory();
                })));
  }
}

Widget _dataTableViaFutureBuilder(BuildContext context) {
  List<Plank> records = context.watch<PlankModel>().history;
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
