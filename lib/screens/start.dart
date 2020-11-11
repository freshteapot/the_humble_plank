import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_humble_plank/screens/login.dart';
import 'package:the_humble_plank/screens/plank_shell.dart';
import 'package:the_humble_plank/plank_model.dart';

class StartScreen extends StatelessWidget {
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
  Future.delayed(const Duration(milliseconds: 100), () async {
    var curveTween = CurveTween(curve: Curves.easeIn);
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, ___) => FadeTransition(
            opacity: animation.drive(curveTween), child: PlankShellScreen()),
        transitionDuration: Duration(seconds: 2),
      ),
    );
  });
}
