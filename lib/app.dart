import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thehumbleplank/notifications.dart';
import 'package:thehumbleplank/screens/plank_history2.dart';

import 'package:thehumbleplank/theme.dart';
import 'package:thehumbleplank/routes.dart';
import 'package:thehumbleplank/screens/start.dart';
import 'package:thehumbleplank/screens/login.dart';
import 'package:thehumbleplank/screens/challenge_join.dart';
import 'package:thehumbleplank/plank_repository.dart';
import 'package:thehumbleplank/credentials_repository.dart';
import 'package:thehumbleplank/challenge_repository.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/user_repository.dart';

class App extends StatelessWidget {
  final CredentialsRepository credentialsRepo;
  final PlankRepository plankRepo;
  final ChallengeRepository challengeRepo;
  final UserRepository userRepo;

  App({
    @required this.plankRepo,
    @required this.credentialsRepo,
    @required this.challengeRepo,
    @required this.userRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) {
              var m = PlankModel(
                repository: plankRepo,
                challengeRepo: challengeRepo,
                credentialsRepo: credentialsRepo,
                userRepo: userRepo,
              );

              m.bootstrap();
              //setupNotifications(context, m);

              return m;
            },
            lazy: false),
      ],
      builder: (context, child) {
        return getApp(context);
      },
    );
  }

  Widget getApp(BuildContext context) {
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
