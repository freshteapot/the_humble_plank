import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:openapi/api.dart';

import 'package:thehumbleplank/app.dart';
import 'package:thehumbleplank/plank_repository.dart';
import 'package:thehumbleplank/credentials_repository.dart';
import 'package:thehumbleplank/challenge_repository.dart';
import 'package:thehumbleplank/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ApiClient apiClient = ApiClient();

  UserApi userApi = UserApi(apiClient);
  PlankApi plankApi = PlankApi(apiClient);
  ChallengeApi challengeApi = ChallengeApi(apiClient);

  RemoteUserRepository userRepo = RemoteUserRepository(
    userApi: userApi,
    apiClient: apiClient,
  );

  RemoteCredentialsRepository credentialsRepo = RemoteCredentialsRepository(
    userApi: userApi,
    apiClient: apiClient,
  );

  RemotePlankRepository plankRepo = RemotePlankRepository(
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
        userRepo: userRepo,
      ),
    ),
  );
}
