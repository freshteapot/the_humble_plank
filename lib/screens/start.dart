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
    print("StartScreen");
    var bootstrapped = context.select((PlankModel model) => model.bootstrapped);

    if (!bootstrapped) {
      Widget body = Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child:
              Center(child: Image(image: AssetImage('assets/icon/icon.png'))));
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
  Future.delayed(const Duration(milliseconds: 100), () async {
    var curveTween = CurveTween(curve: Curves.easeIn);
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, ___) => FadeTransition(
            opacity: animation.drive(curveTween), child: PlankShellScreen()),
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  });
}
