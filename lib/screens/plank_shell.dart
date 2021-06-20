import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/screens/challenges_overview.dart';
import 'package:thehumbleplank/screens/plank_history.dart';
import 'package:thehumbleplank/screens/plank_screen.dart';
import 'package:thehumbleplank/screens/plank_settings.dart';
import 'package:thehumbleplank/utils.dart';
import 'package:thehumbleplank/widget/topbar.dart';

class PlankShellScreen extends StatefulWidget {
  PlankShellScreen();

  @override
  _PlankShellScreenState createState() => _PlankShellScreenState();
}

class _PlankShellScreenState extends State<PlankShellScreen> {
  int _currentIndex = 1;
  int loaded = 0;

  bool _showChallenge = true;
  String _shownNotificationId = "";
  @override
  void initState() {
    super.initState();
    /*
    Challenge challenge = context.read<PlankModel>().challenge;
    bool showChallenge = context.read<PlankModel>().showChallenge;

    bool showChallengeNotification =
        context.read<PlankModel>().showChallengeNotification;
    bool appPushNotificationsShown =
        context.read<PlankModel>().appPushNotificationsShown;

    print("""
initState

challenge=${challenge.toJson()}
showChallenge=$showChallenge
showChallengeNotification=$showChallengeNotification
appPushNotificationsShown=$appPushNotificationsShown
    """);
    loaded = 1;
    */
  }

  Widget getChallengeScreen() {
    return ChallengesOverviewScreen(
        title: "Challenge 1",
        onPressed: () {
          setState(() {
            _currentIndex = 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    print("Why do I load twice? $_currentIndex, loaded=$loaded");

    bool offline = context.select((PlankModel model) => model.offline);

    if (offline) {
      // TODO how to handle offline
      print("We are offline, give some indication");
    }

    // Check if 403
    bool loggedIn = context.select((PlankModel model) => model.loggedIn);

    if (!loggedIn) {
      Widget body = Container(
          color: Colors.white,
          child: SizedBox.shrink(
              child: Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.GROUNDED,
            title: "You are no longer logged.",
            message: "You need to log in again.",
            blockBackgroundInteraction: true,
            mainButton: TextButton(
              onPressed: () {
                context.read<PlankModel>().logout();
                Phoenix.rebirth(context);
              },
              child: Text(
                "Click to login",
                style: TextStyle(color: Colors.amber),
              ),
            ),
          )));
      return body;
    }

    Challenge challenge = context.select((PlankModel model) => model.challenge);
    bool showChallenge =
        context.select((PlankModel model) => model.showChallenge);
    bool showChallengeNotification =
        context.select((PlankModel model) => model.showChallengeNotification);

    bool showIntervals =
        context.select((PlankModel model) => model.showIntervals);
    int intervalTime = context.select((PlankModel model) => model.intervalTime);

    List<Challenge> challenges =
        context.select((PlankModel model) => model.challenges);
    List<Plank> history = context.select((PlankModel model) => model.history);

    String latestNotificationId =
        context.select((PlankModel model) => model.latestNotificationId);
    String lastNotificationId =
        context.select((PlankModel model) => model.lastNotificationId);
    String notificationAction =
        context.select((PlankModel model) => model.notificationAction);

    bool appPushNotificationsShown =
        context.select((PlankModel model) => model.appPushNotificationsShown);

    print("""
loggedIn=$loggedIn
challenge=${challenge.toJson()}
showChallenge=$showChallenge
showChallengeNotification=$showChallengeNotification
showIntervals=$showIntervals
intervalTime=$intervalTime
challenges=${challenges.length}
history=${history.length}
latestNotificationId=$latestNotificationId
lastNotificationId=$lastNotificationId
notificationAction=$notificationAction
appPushNotificationsShown=$appPushNotificationsShown
    """);
    bool showChallengeChanged = false;
    if (_showChallenge != showChallenge) {
      showChallengeChanged = true;
    }

    if (_currentIndex == 1 &&
        challenges.length > 0 &&
        !showChallengeNotification) {
      loaded = 1;
      print("""
          Will show nag screen:
            appPushNotificationsShown=$appPushNotificationsShown
          """);
      _notificationNag(context);
    }

    // Out the box challenge will cause this to show the correct one
    List<Widget> screens = [
      PlankHistoryScreen(
        challenges: challenges,
        currentChallenge: challenge,
        history: history,
      ),
      PlankScreen(
        showIntervals: showIntervals,
        intervalTime: intervalTime,
        currentChallenge: challenge,
        challenges: challenges,
      ),
      getChallengeScreen(),
      PlankSettings(),
    ];

    BottomNavigationBarItem historyBarItem =
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History');

    List<BottomNavigationBarItem> bottomNavItems = [
      historyBarItem,
      BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Plank'),
      BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events), label: 'Challenge'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ];

    // Via settings, toggling the challenge, removes the challenge tab
    // Logic to handle if the challenge tab has been disabled
    if (showChallengeChanged) {
      int newIndex = _currentIndex;
      if (!showChallenge) {
        if (_currentIndex > 2) {
          newIndex = 2;
        }
      }

      if (showChallenge) {
        if (_currentIndex == 2) {
          newIndex = 3;
        }
      }

      _currentIndex = newIndex;
      _showChallenge = showChallenge;
    }

    if (!showChallenge) {
      screens.removeAt(2);
      bottomNavItems.removeAt(2);
    }
    // end of toggling the challenge tab logic

    // TODO if timer is running do not change the page.
    // TODO make plankModel aware timer has started

    // the challenge should change, if it doesnt then we dont need to rerender.
    // The logic below might be overkill for reloading.
    // The logic below is needed to make sure a new notification triggers a rebuild.

    if (showChallenge &&
        notificationAction == "challenge.updated" &&
        (lastNotificationId != latestNotificationId)) {
      if (_shownNotificationId != latestNotificationId) {
        _currentIndex = 0;
        _shownNotificationId = latestNotificationId;
      }
    }

    Widget bottomNav = BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: bottomNavItems,
      currentIndex: _currentIndex,
      onTap: (newIndex) {
        if (newIndex == 0) {
          // TODO to load my history or to load challenge history?
          // TODO how to move signal onto the challenge?
          if (context.read<PlankModel>().history.length == 0) {
            context.read<PlankModel>().loadHistory();
          }
        }
        setState(() {
          _currentIndex = newIndex;
        });
      },
    );

    return Scaffold(
      appBar: topBar(),
      bottomNavigationBar: bottomNav,
      body: screens[_currentIndex], // new
    );
  }
}

Future<void> _notificationNag(BuildContext context) async {
  await Future.delayed(Duration(seconds: 1));
  return showAlertDialog(context);
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () async {
      await context.read<PlankModel>().setShownChallengeNotification(true);
      Navigator.of(context).pop();
      await Future.delayed(Duration(seconds: 1));
      checkAndAskForNotificationPermission(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("You have challenges!"),
    content: Text(
        "Would you like to enable notifications for when your friends plank?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
