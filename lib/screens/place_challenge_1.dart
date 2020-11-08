import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:the_humble_plank/plank_model.dart';
import 'package:the_humble_plank/learnalist/challenge.dart';
import 'package:the_humble_plank/screens/challenge_join.dart';
import 'package:the_humble_plank/widget/onshare.dart';

class PlankChallenge1 extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final VoidCallback onCreate;
  final VoidCallback onHistory;

  PlankChallenge1({
    this.title,
    this.onPressed,
    this.onCreate,
    this.onHistory,
  });

  @override
  _PlankChallenge1State createState() => _PlankChallenge1State();
}

class _PlankChallenge1State extends State<PlankChallenge1> {
  List<Widget> _items;
  @override
  Widget build(BuildContext context) {
    List<Challenge> challenges = context.watch<PlankModel>().challenges;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (challenges.isNotEmpty) ...[
            Container(
              alignment: Alignment.center,
              child: Text(
                "Active Challenges",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
          Container(
            height: MediaQuery.of(context).size.height / 1.8,
            child: listOfChallenges(context, challenges),
          ),
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
                  // Create or ask for name

                  await showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0,
                                        20.0, 20.0, 0.0), // content padding
                                    child: ChallengeJoinScreen())));
                      });
                },
                child: Text(
                  "Join a  challenge",
                  style: TextStyle(fontSize: 20.0),
                ),
              )),
          Container(
              alignment: Alignment.center,
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  // Create or ask for name
                  widget.onCreate();
                },
                child: Text(
                  "Create a new challenge",
                  style: TextStyle(fontSize: 20.0),
                ),
              ))
        ]);
  }

  Widget listOfChallenges(BuildContext context, List<Challenge> challenges) {
    return listOfChallenges1(context, challenges);
  }

  Widget listOfChallenges1(BuildContext context, List<Challenge> challenges) {
    _items = challenges.map((challenge) {
      return challengeTile(context, challenge);
    }).toList();

    return ListView(padding: const EdgeInsets.all(8), children: _items);
  }

  Widget challengeTile(BuildContext context, Challenge challenge) {
    return challengeTileExpand(context, challenge);
  }

  Widget challengeTileSimple(BuildContext context, Challenge challenge) {
    return Card(
      child: ListTile(
          title: Text(challenge.description),
          trailing: Icon(Icons.timer),
          onTap: () {
            // Now how do I update the tab
            context.read<PlankModel>().setChallenge(challenge);
            widget.onPressed();
          }),
    );
  }

  Widget challengeTileExpand(BuildContext context, Challenge challenge) {
    return Card(
        child: ExpansionTile(
            key: Key(challenge.uuid),
            trailing: SizedBox.shrink(),
            title: Text(challenge.description,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black,
                )),
            childrenPadding: EdgeInsets.all(8.0),
            children: <Widget>[menuRow(context, challenge)]));
  }

  Widget menuRow(BuildContext context, Challenge challenge) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SizedBox(
          width: 60, // specific value
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.history,
                  size: 18,
                ),
                Text("History"),
              ],
            ),
            onPressed: () async {
              await context
                  .read<PlankModel>()
                  .getChallengeWithHistory(challenge.uuid);
              //context.read<PlankModel>().setChallenge(challenge);
              widget.onHistory();
            },
          )),
      SizedBox(
          width: 60, // specific value
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.timer, size: 18),
                Text("plank"),
              ],
            ),
            onPressed: () {
              context.read<PlankModel>().setChallenge(challenge);
              widget.onPressed();
            },
          )),
      SizedBox(
          width: 60, // specific value
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.share, size: 18),
                Text("Share"),
              ],
            ),
            onPressed: () {
              shareChallenge(context, challenge);
            },
          )),
      SizedBox(
          width: 60, // specific value
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.close, size: 18),
                Text("Leave"),
              ],
            ),
            onPressed: () {
              context.read<PlankModel>().leaveChallenge(challenge.uuid);
            },
          )),
    ]);
  }
}
