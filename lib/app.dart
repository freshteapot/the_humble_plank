import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thehumbleplank/theapp.dart';
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
              return m;
            },
            lazy: false),
      ],
      builder: (context, child) {
        return TheApp();
      },
    );
  }
}
