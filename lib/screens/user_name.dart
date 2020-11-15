import 'package:flutter/material.dart';

void displaySettingsModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return SettingsModal();
      });

  //showDialog(context: context, child: SettingsModal());
}

class SettingsModal extends StatelessWidget {
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop();
            return false;
          },
          child: GestureDetector(
              //behavior: HitTestBehavior.opaque,
              onTap: () {
                myFocusNode.unfocus();
              }, //prevents taps inside the sheet from popping it
              onVerticalDragStart: (_) {
                Navigator.of(context).pop();
              },
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Form(
                    child: GestureDetector(
                        //behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print("In form");

                          FocusScopeNode currentFocus = FocusScope.of(context);
                          myFocusNode.unfocus();
                          currentFocus.unfocus();
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(10.0),
                            color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Text("Enter your text below:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                ),
                                TextFormField(
                                  focusNode: myFocusNode,
                                  onTap: () {
                                    print(myFocusNode.hasFocus);
                                  },
                                  onEditingComplete: () {
                                    print("editing complete");
                                    myFocusNode.unfocus();
                                  },
                                  onFieldSubmitted: (a) {
                                    print("editing complete1");
                                  },
                                  //keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    border: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.teal)),
                                  ),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {},
                                )
                              ],
                            ))),
                  ))));
    });
  }
}
