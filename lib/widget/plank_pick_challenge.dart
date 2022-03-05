import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/widget/challenge_menu.dart';

class PlankPickChallenge extends StatelessWidget {
  PlankPickChallenge({
    this.challenges,
    this.currentChallengeUUID,
    this.previousChallengeUUID,
    this.onTap,
  });

  final List<Challenge> challenges;
  final String currentChallengeUUID;
  final String previousChallengeUUID;
  final Function(ChallengeMenu item) onTap;

  @override
  Widget build(BuildContext context) {
    List<Challenge> filteredChallenges = challenges.toList();
    // Sort first, lowercase is important!
    filteredChallenges.sort((Challenge a, Challenge b) =>
        a.description.toLowerCase().compareTo(b.description.toLowerCase()));

    String findUUID = "";
    if (previousChallengeUUID.isNotEmpty) {
      findUUID = previousChallengeUUID;
    }
    // Give priority to the currentChallengeUUID
    if (currentChallengeUUID.isNotEmpty) {
      findUUID = currentChallengeUUID;
    }

    // Move the challenge to the top
    if (findUUID.isNotEmpty) {
      Challenge found = filteredChallenges
          .firstWhere((challenge) => challenge.uuid == findUUID);
      filteredChallenges.removeWhere((challenge) => challenge.uuid == findUUID);
      if (found != null) {
        filteredChallenges.insert(0, found);
      }
    }

    List<ChallengeMenu> items = <ChallengeMenu>[
      ChallengeMenu(name: "All my planks", type: 1)
    ];

    items.addAll(filteredChallenges.map((challenge) {
      return ChallengeMenu(
          name: challenge.description, type: 2, data: challenge);
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
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1.0))),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: const Text('Pick from'),
                ),
                Expanded(
                  // A flexible child that will grow to fit the viewport but
                  // still be at least as big as necessary to fit its contents.
                  child: Container(
                    height: 120.0,
                    //padding: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    child: ListView.separated(
                      padding: EdgeInsets.all(0.0),
                      itemCount: items.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 0,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Center(child: Text('${items[index].name}')),
                          onTap: () async {
                            onTap(items[index]);
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
}
