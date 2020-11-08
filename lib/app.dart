import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_humble_plank/theme.dart';
import 'package:the_humble_plank/routes.dart';
import 'package:the_humble_plank/screens/start.dart';
import 'package:the_humble_plank/screens/login.dart';
import 'package:the_humble_plank/screens/challenge_join.dart';
import 'package:the_humble_plank/plank_repository.dart';
import 'package:the_humble_plank/credentials_repository.dart';
import 'package:the_humble_plank/challenge_repository.dart';
import 'package:the_humble_plank/plank_model.dart';

class App extends StatelessWidget {
  final CredentialsRepository credentialsRepo;
  final PlankRepository plankRepo;
  final ChallengeRepository challengeRepo;
  App({
    @required this.plankRepo,
    @required this.credentialsRepo,
    @required this.challengeRepo,
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
              );

              m.bootstrap();

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
        title: 'Humble plank',
        initialRoute: initialRoute,
        theme: AppTheme.theme,
        routes: {
          AppRoutes.start: (context) => StartScreen(),
          AppRoutes.login: (context) => LoginScreen(),
          AppRoutes.challengeJoin: (context) => ChallengeJoinScreen(),
        });
  }
}
