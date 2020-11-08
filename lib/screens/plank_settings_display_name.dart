import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class PlankSettingsDisplayNameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[PlankSettingsDisplayNameForm()]))
    ]);
  }
}

class PlankSettingsDisplayNameForm extends StatefulWidget {
  @override
  _PlankSettingsDisplayNameState createState() =>
      _PlankSettingsDisplayNameState();
}

class _PlankSettingsDisplayNameState
    extends State<PlankSettingsDisplayNameForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'Display Name',
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
          padding: EdgeInsets.symmetric(vertical: 20),
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
              String displayName = input.trim();
              // TODO How to secure this?
              if (displayName.length > 20) {
                Flushbar(
                  backgroundColor: Colors.red[600],
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  title: "Error",
                  message:
                      "Your display name is too long. '${displayName.substring(0, 20)}' is allowed",
                  duration: Duration(seconds: 5),
                  blockBackgroundInteraction: true,
                )..show(context);
                return;
              }

              // TODO save to server
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                flushbarStyle: FlushbarStyle.GROUNDED,
                title: "TODO",
                message: "Save displayName to the backend '${displayName}'",
                duration: Duration(seconds: 5),
                blockBackgroundInteraction: true,
              )..show(context);

              // On success close this
              //Navigator.of(context).pop();
            },
            child: Text(
              "Save",
              style: TextStyle(fontSize: 20.0),
            ),
          )),
    ]);
  }
}
