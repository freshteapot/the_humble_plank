import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';

import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/screens/place_challenge_1.dart';
import 'package:thehumbleplank/screens/place_challenge_2.dart';
import 'package:thehumbleplank/screens/place_challenge_history.dart';
import 'package:thehumbleplank/screens/plank_history.dart';
import 'package:thehumbleplank/screens/plank_screen.dart';
import 'package:thehumbleplank/screens/plank_settings.dart';
import 'package:thehumbleplank/widget/topbar.dart';

class PlankShellScreen extends StatefulWidget {
  int startAt = 1;
  PlankShellScreen({this.startAt});

  @override
  _PlankShellScreenState createState() => _PlankShellScreenState();
}

class _PlankShellScreenState extends State<PlankShellScreen> {
  int _currentIndex = 1;
  int _challengeScreenIndex = 0;
  bool _showChallenge = true;
  String _shownNotificationId = "";
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startAt;
  }

  Widget getChallengeScreen() {
    return PlankChallenge1(
        title: "Challenge 1",
        onPressed: () {
          setState(() {
            _currentIndex = 1;
            _challengeScreenIndex = 0;
          });
        },
        onCreate: () {
          setState(() {
            _challengeScreenIndex = 1;
          });
        },
        onHistory: () {
          setState(() {
            _challengeScreenIndex = 2;
          });
        });
  }

  Widget createChallengeScreen() {
    return PlankChallenge2(onCreate: (Challenge challenge) {
      setState(() {
        _currentIndex = 2;
        _challengeScreenIndex = 0;
      });
    });
  }

  Widget historyChallengeScreen() {
    return PlankChallengeHistory(onPlank: () {
      setState(() {
        _currentIndex = 1;
        _challengeScreenIndex = 0;
      });
    }, onLeave: () {
      _currentIndex = 2;
      _challengeScreenIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if online
    bool offline = context.select((PlankModel model) => model.offline);

    if (offline) {
      // TODO
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
            mainButton: FlatButton(
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
    bool showIntervals =
        context.select((PlankModel model) => model.showIntervals);
    int intervalTime = context.select((PlankModel model) => model.intervalTime);

    bool showChallengeChanged = false;
    if (_showChallenge != showChallenge) {
      showChallengeChanged = true;
    }

    var challengeScreen = [
      getChallengeScreen(),
      createChallengeScreen(),
      historyChallengeScreen()
    ].elementAt(_challengeScreenIndex);

    List<Challenge> challenges =
        context.select((PlankModel model) => model.challenges);

    List<Plank> history = context.select((PlankModel model) => model.history);
    bool newHistory = context.select((PlankModel model) => model.newHistory);

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
        challenge: challenge,
      ),
      challengeScreen,
      PlankSettings(),
    ];

    BottomNavigationBarItem historyBarItem =
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History');
    if (newHistory) {
      historyBarItem = new BottomNavigationBarItem(
        label: 'History',
        icon: new Stack(children: <Widget>[
          new Icon(Icons.history),
          new Positioned(
            // draw a red marble
            top: 0.0,
            right: 0.0,
            child: new Icon(Icons.brightness_1,
                size: 10.0, color: Colors.redAccent),
          )
        ]),
      );
    }
    List<BottomNavigationBarItem> bottomNavItems = [
      historyBarItem,
      //BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
      /*
      new BottomNavigationBarItem(
        label: 'History',
        icon: new Stack(children: <Widget>[
          new Icon(Icons.history),
          new Positioned(
            // draw a red marble
            top: 0.0,
            right: 0.0,
            child: new Icon(Icons.brightness_1,
                size: 10.0, color: Colors.redAccent),
          )
        ]),
      ),
      */
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
    String latestNotificationId =
        context.select((PlankModel model) => model.latestNotificationId);
    String lastNotificationId =
        context.select((PlankModel model) => model.lastNotificationId);
    String notificationAction =
        context.select((PlankModel model) => model.notificationAction);

    if (showChallenge &&
        notificationAction == "challenge:updated" &&
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
      currentIndex: _currentIndex, // new

      onTap: (newIndex) {
        if (newIndex == 0) {
          // TODO to load my history or to load challenge history?
          // TODO how to move signal onto the challenge?
          context.read<PlankModel>().clearNewHistorySignal();
          if (context.read<PlankModel>().history.length == 0) {
            context.read<PlankModel>().loadHistory();
          }
        }
        setState(() {
          _currentIndex = newIndex;
          _challengeScreenIndex = 0;
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
