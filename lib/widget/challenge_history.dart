import 'package:flutter/material.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:jiffy/jiffy.dart';

import 'package:thehumbleplank/utils.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';

Widget challengeHistoryDataView(BuildContext context, Challenge challenge) {
  // TODO why is this empty?
  // This breaks, when I set the challenge without getting the history
  Map<String, String> users = new Map<String, String>();
  challenge.users.forEach((user) {
    users[user.userUuid] = user.name;
  });

  return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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

            // Why??
            String userName = "na";
            if (users[record.userUuid] != null) {
              userName = users[record.userUuid];
            }

            return DataRow(cells: <DataCell>[
              DataCell(Text(formatTime(record.timerNow))),
              DataCell(
                Text(Jiffy(when).fromNow()),
              ),
              DataCell(Text(userName)),
            ]);
          }).toList()));
}
