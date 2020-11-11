import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'package:the_humble_plank/plank_model.dart';
import 'package:the_humble_plank/screens/plank_settings_display_name.dart';

class PlankSettings extends StatefulWidget {
  PlankSettings();

  @override
  _PlankSettingsState createState() => _PlankSettingsState();
}

class _PlankSettingsState extends State<PlankSettings> {
  Widget build(BuildContext context) {
    var showChallenge = context.watch<PlankModel>().showChallenge;

    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: FlatButton(
                    color: Colors.grey,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueGrey,
                    onPressed: () async {
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
                                        child:
                                            PlankSettingsDisplayNameScreen())));
                          });
                    },
                    child: Text(
                      "Change your display name",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
                  ...intervalWidget(context),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 0, right: 0, bottom: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SwitchListTile(
                                title: const Text('Challenge screen'),
                                value: showChallenge,
                                activeColor: Colors.green,
                                onChanged: (bool value) {
                                  setState(() {
                                    context
                                        .read<PlankModel>()
                                        .setShowChallenge(value);
                                  });
                                })
                          ])),
                  SwitchListTile(
                      title: const Text('Logout and clear the app'),
                      value: false,
                      activeColor: Colors.red,
                      inactiveTrackColor: Colors.red,
                      onChanged: (bool value) async {
                        await context.read<PlankModel>().logout();
                        Phoenix.rebirth(context);
                      }),
                ])));
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

List<Widget> intervalWidget(BuildContext context) {
  var showIntervals = context.watch<PlankModel>().showIntervals;
  var intervalTime = context.watch<PlankModel>().intervalTime.toDouble();
  var intervalText = "Off";
  if (intervalTime > 0) {
    intervalText = "${intervalTime.toInt()} seconds";
  }

  return [
    SwitchListTile(
      title: const Text('Intervals'),
      value: showIntervals,
      activeColor: Colors.grey,
      onChanged: (bool value) {
        if (!value) {
          context.read<PlankModel>().setShowIntervals(false);
          context.read<PlankModel>().setIntervalTime(0);
        } else {
          context.read<PlankModel>().setShowIntervals(true);
          context.read<PlankModel>().setIntervalTime(15);
        }
      },
    ),
    Center(
      child: Text(
        intervalText,
        textAlign: TextAlign.center,
      ),
    ),
    SliderTheme(
      data: SliderThemeData(
        //trackShape: CustomTrackShape(),
        inactiveTrackColor: Colors.grey[200],
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
        activeTrackColor: Colors.grey,
        thumbColor: Colors.grey,
        overlayColor: Colors.transparent,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
      ),
      child: Slider(
        value: intervalTime,
        min: 0,
        max: 60,
        divisions: 12,
        onChanged: (double value) {
          context.read<PlankModel>().setIntervalTime(value.toInt());

          if (value == 0) {
            context.read<PlankModel>().setShowIntervals(false);
            return;
          }

          if (!showIntervals) {
            context.read<PlankModel>().setShowIntervals(true);
          }
        },
      ),
    ),
  ];
}
