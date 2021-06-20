import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:thehumbleplank/notifications.dart';

import 'package:thehumbleplank/theme.dart';
import 'package:thehumbleplank/routes.dart';
import 'package:thehumbleplank/screens/start.dart';
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
      print("Welcome back, fellow planker");

      // This is all here for the settings screen, perhaps I delete it?
      // Perhaps I change settings screen to click to enable notifications and handle it there?
      PermissionStatus permission = await Permission.notification.status;

      bool newState = permission.isGranted;
      if (newState != context.read<PlankModel>().appPushNotifications) {
        await context.read<PlankModel>().setPushNotifications(newState);
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
        });
  }
}
