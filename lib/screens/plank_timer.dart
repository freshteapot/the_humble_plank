import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import 'package:openapi/api.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/notifications.dart';

import 'package:thehumbleplank/widget/bottombar.dart';
import 'package:thehumbleplank/widget/topbar.dart';

class PlankTimerScreen extends StatefulWidget {
  PlankTimerScreen();

  @override
  _PlankHistoryScreenState createState() => _PlankHistoryScreenState();
}

class _PlankHistoryScreenState extends State<PlankTimerScreen> {
  @override
  Widget build(BuildContext context) {
    final MessageArguments args = ModalRoute.of(context).settings.arguments;
    print("MessageArguments $args");
    double historyHeight = MediaQuery.of(context).size.height / 1.3;

    Widget bottomNav = bottomBar((newIndex) {
      print("TODO");
    }, 1, false);

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
                    child: Text("Hello"),
                  ),
                ])));
  }
}
