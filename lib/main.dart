import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:openapi/api.dart';

import 'package:the_humble_plank/app.dart';
import 'package:the_humble_plank/plank_repository.dart';
import 'package:the_humble_plank/credentials_repository.dart';
import 'package:the_humble_plank/challenge_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient apiClient = ApiClient();

  UserApi userApi = UserApi(apiClient);
  PlankApi plankApi = PlankApi(apiClient);
  ChallengeApi challengeApi = ChallengeApi(apiClient);

  RemoteCredentialsRepository credentialsRepo = RemoteCredentialsRepository(
    userApi: userApi,
    apiClient: apiClient,
  );

  PlankRepository plankRepo = PlankRepository(
    plankApi: plankApi,
    apiClient: apiClient,
  );

  ChallengeRepository challengeRepo = ChallengeRepository(
    challengeApi: challengeApi,
    apiClient: apiClient,
  );
  Provider.debugCheckInvalidValueType = null;

  runApp(
    Phoenix(
      child: App(
        plankRepo: plankRepo,
        credentialsRepo: credentialsRepo,
        challengeRepo: challengeRepo,
      ),
    ),
  );
}
