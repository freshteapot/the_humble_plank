import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_humble_plank/learnalist/challenge.dart';
import 'package:the_humble_plank/plank_model.dart';
import 'package:the_humble_plank/widget/onshare.dart';

class _callToActionItem {
  String title;
  GestureTapCallback onTap;

  _callToActionItem({this.title, this.onTap})
      : assert(title != null),
        assert(onTap != null);
}

Widget plankScreenCallToAction(BuildContext context, Challenge challenge) {
  List<_callToActionItem> items = [
    _callToActionItem(
        title: "Plank without challenge",
        onTap: () async {
          await context.read<PlankModel>().setChallenge(Challenge.empty());
          Navigator.pop(context);
        }),
    _callToActionItem(
        title: "Share",
        onTap: () async {
          await shareChallenge(context, challenge);
          Navigator.pop(context);
        }),
  ];

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
                child: Text(challenge.description),
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
                        title: Text(items[index].title),
                        onTap: items[index].onTap,
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
