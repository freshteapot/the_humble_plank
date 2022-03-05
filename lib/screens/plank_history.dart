import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:openapi/api.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/theme.dart';
import 'package:thehumbleplank/widget/plank_challenge_history.dart';
import 'package:thehumbleplank/widget/challenge_menu.dart';
import 'package:thehumbleplank/widget/plank_history.dart';
import 'package:thehumbleplank/widget/plank_pick_challenge.dart';

class PlankHistoryScreen extends StatefulWidget {
  List<Plank> history;
  List<Challenge> challenges;
  Challenge currentChallenge;
  String currentChallengeUUID;
  String previousChallengeUUID;
  PlankHistoryScreen({
    this.history,
    this.challenges,
    this.currentChallenge,
    this.currentChallengeUUID,
    this.previousChallengeUUID,
  });

  @override
  _PlankHistoryScreenState createState() => _PlankHistoryScreenState();
}

class _PlankHistoryScreenState extends State<PlankHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    Widget historyView;
    double historyHeight = MediaQuery.of(context).size.height / 1.4;
    bool showChallenges = widget.challenges.length > 0;
    bool showChallenge = widget.currentChallenge.uuid != "";

    if (showChallenges) {
      historyHeight = MediaQuery.of(context).size.height / 1.5;
    }

    if (showChallenge) {
      historyView = RefreshIndicator(
          child: plankChallengeHistoryView(context, widget.currentChallenge),
          onRefresh: () async {
            await context
                .read<PlankModel>()
                .getChallengeWithHistory(widget.currentChallenge.uuid);
          });
    } else {
      historyView = RefreshIndicator(
          //child: _dataTableViaFutureBuilder(context, widget.history),
          child: plankHistoryView(context, widget.history),
          onRefresh: () {
            return context.read<PlankModel>().loadHistory();
          });
    }

    return Scaffold(
        backgroundColor: Colors.white,
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
                        child: TextButton(
                          style: primaryButtonStyle(),
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
                                                  .setChallenge(
                                                      Challenge.empty());
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
                                        )),
                                  );
                                });
                            //
                          },
                          child: Text(
                            "Pick a Challenge",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ))
                  ],
                ])));
  }
}
