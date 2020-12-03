import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/utils.dart';

class ChallengeJoinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCustomForm();
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  final regexp = RegExp(".*\/challenge\/(.*)\.html");

  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Enter challenge uuid or url',
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
          ),
        ),
      ),
      TextField(
        controller: myController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 50),
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () async {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }

              String input = myController.text;
              // Handle as uuid
              // if learnalist.net
              // Extract the uuid from the url
              String uuid = input;
              if (input.contains("https://")) {
                if (regexp.hasMatch(input)) {
                  uuid = regexp.firstMatch(input).group(1);
                }
              }

              if (uuid.isEmpty) {
                Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  title: "Error",
                  message: "You cant join an empty challenge.",
                  duration: Duration(seconds: 5),
                  blockBackgroundInteraction: true,
                )..show(context);
                return;
              }
              bool joined =
                  await context.read<PlankModel>().joinChallenge(uuid);

              if (!joined) {
                Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  title: "Error",
                  message:
                      "Failed to join challenge, perhaps the code is wrong?",
                  duration: Duration(seconds: 5),
                  blockBackgroundInteraction: true,
                )..show(context);
                return;
              }

              await checkAndAskForNotificationPermission(context);
              Navigator.of(context).pop();
            },
            child: Text(
              "Join",
              style: TextStyle(fontSize: 20.0),
            ),
          )),
    ]);
  }
}
