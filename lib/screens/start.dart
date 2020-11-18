import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thehumbleplank/notifications.dart';

import 'package:thehumbleplank/screens/login.dart';
import 'package:thehumbleplank/screens/plank_shell.dart';
import 'package:thehumbleplank/plank_model.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    var m = context.read<PlankModel>();
    setupNotifications(context, m);
  }

  @override
  Widget build(BuildContext context) {
    var bootstrapped = context.select((PlankModel model) => model.bootstrapped);

    if (!bootstrapped) {
      // TODO this could be a logo
      Widget body = SizedBox.shrink();
      return Scaffold(backgroundColor: Colors.white, body: body);
    }

    // When the app loaded were we logged in?
    var loggedIn = context.select((PlankModel model) => model.bootstrapLogin);
    if (!loggedIn) {
      _showLogin(context);
    } else {
      _redirectToMain(context);
    }

    Widget body = SizedBox.shrink();
    return Scaffold(backgroundColor: Colors.white, body: body);
  }
}

void _showLogin(BuildContext context) async {
  Future.delayed(const Duration(milliseconds: 100), () async {
    var curveTween = CurveTween(curve: Curves.easeIn);
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, ___) => FadeTransition(
            opacity: animation.drive(curveTween), child: LoginScreen()),
        transitionDuration: Duration(seconds: 1),
      ),
    );
  });
}

void _redirectToMain(BuildContext context) {
  // I dont want this in here :(
  // Due to the navigator push
  // What I really want is push window which then changes the tab?
  //int startAt = context.select((PlankModel model) => model.startAt);
  //String latestNotificationId =
  //context.select((PlankModel model) => model.latestNotificationId);
  //print("latestNotificationId $latestNotificationId");

  Future.delayed(const Duration(milliseconds: 100), () async {
    var curveTween = CurveTween(curve: Curves.easeIn);
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, ___) => FadeTransition(
            opacity: animation.drive(curveTween),
            child: PlankShellScreen(
              startAt: 1,
            )),
        transitionDuration: Duration(seconds: 2),
      ),
    );
  });
}
