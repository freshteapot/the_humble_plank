import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:openapi/api.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/widget/plank_challenge_history.dart';
import 'package:thehumbleplank/widget/challenge_menu.dart';
import 'package:thehumbleplank/widget/plank_history.dart';

class PlankHistoryScreen extends StatefulWidget {
  List<Plank> history;
  List<Challenge> challenges;
  Challenge currentChallenge;
  PlankHistoryScreen({
    this.history,
    this.challenges,
    this.currentChallenge,
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
                            "Pick a Challenge",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ))
                  ],
                ])));
  }
}

Widget _challengesView(BuildContext context, List<Challenge> challenges) {
  List<ChallengeMenu> items = List<ChallengeMenu>();
  items.add(ChallengeMenu(name: "All my planks", type: 1));
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
