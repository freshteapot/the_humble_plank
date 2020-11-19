import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:thehumbleplank/screens/plank_history2.dart';

import 'package:thehumbleplank/theme.dart';
import 'package:thehumbleplank/routes.dart';
import 'package:thehumbleplank/screens/start.dart';
import 'package:thehumbleplank/screens/login.dart';
import 'package:thehumbleplank/screens/challenge_join.dart';
import 'package:thehumbleplank/plank_model.dart';

class TheApp extends StatefulWidget {
  TheApp();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<TheApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.notification);

      // This can be used for the UI but I dont think I should link it to the server
      if ([PermissionStatus.granted, PermissionStatus.denied]
          .contains(permission)) {
        bool newState = permission == PermissionStatus.granted ? true : false;
        if (newState != context.read<PlankModel>().appPushNotifications) {
          // Update notifications and ping the server
          await context.read<PlankModel>().setPushNotifications(newState);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String initialRoute = AppRoutes.start;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Humble plank',
        initialRoute: initialRoute,
        theme: AppTheme.theme,
        routes: {
          AppRoutes.start: (context) => StartScreen(),
          AppRoutes.login: (context) => LoginScreen(),
          AppRoutes.plankHistory: (context) => PlankHistoryScreen2(),
          AppRoutes.challengeJoin: (context) => ChallengeJoinScreen(),
        });
  }
}
