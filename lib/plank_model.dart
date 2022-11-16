import 'dart:collection';
import 'dart:core';

import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:openapi/api.dart';
import 'package:thehumbleplank/credentials_repository.dart';
import 'package:thehumbleplank/env.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';
import 'package:thehumbleplank/learnalist/dialog_error.dart';
import 'package:thehumbleplank/mobile_repository.dart';
import 'package:thehumbleplank/plank_repository.dart';
import 'package:thehumbleplank/challenge_repository.dart';
import 'package:thehumbleplank/user_repository.dart';
import 'package:thehumbleplank/utils.dart';
import 'package:thehumbleplank/notifications.dart';

LearnalistEnv learnalistEnv = LearnalistEnv.defaultValues();

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[],
);

class PlankModel extends ChangeNotifier {
  final PlankRepository repository;
  final ChallengeRepository challengeRepo;
  final CredentialsRepository credentialsRepo;
  final UserRepository userRepo;
  final MobileRepository mobileRepo;

  Credentials _credentials = Credentials();
  Credentials get credentials => _credentials;

  bool _isLoading;
  bool get isLoading => _isLoading;

  bool _isError;
  bool get isError => _isError;

  bool _loggedIn;
  bool get loggedIn => _loggedIn;

  DialogError _dialogError;
  DialogError get dialogError => _dialogError;

  // A flag to know when the sever is offline
  bool _offline;
  bool get offline => _offline;

  bool _showIntervals;
  bool get showIntervals => _showIntervals;

  bool _showChallenge;
  bool get showChallenge => _showChallenge;

  bool _challengeNotificationShownOnCreate;
  bool get challengeNotificationShownOnCreate =>
      _challengeNotificationShownOnCreate;

  bool _challengeNotificationShownOnJoin;
  bool get challengeNotificationShownOnJoin =>
      _challengeNotificationShownOnJoin;

  bool _challengeNotificationShownOnPlank;
  bool get challengeNotificationShownOnPlank =>
      _challengeNotificationShownOnPlank;

  bool _challengeNotificationShownWithChallenges;
  bool get challengeNotificationShownWithChallenges =>
      _challengeNotificationShownWithChallenges;

  String _currentChallengeUUID;
  String get currentChallengeUUID => _currentChallengeUUID;

  String _previousChallengeUUID;
  String get previousChallengeUUID => _previousChallengeUUID;
  Challenge _challenge;
  Challenge get challenge => _challenge;

  List<Challenge> _challenges;
  List<Challenge> get challenges => UnmodifiableListView(_challenges);

  int _intervalTime;
  int get intervalTime => _intervalTime;

  List<Plank> _history;
  UnmodifiableListView<Plank> get history => UnmodifiableListView(_history);

  bool _bootstrapping;
  bool _bootstrapped;
  bool get bootstrapped => _bootstrapped;

  // After bootstrap, are we logged in?
  bool _bootstrapLogin;
  bool get bootstrapLogin => _bootstrapLogin;

  dynamic _lastError;
  dynamic get lastError => _lastError;

  String _displayName;
  String get displayName => _displayName;

  bool _showCallToActionForDisplayName;
  bool get showCallToActionForDisplayName => _showCallToActionForDisplayName;
  bool _skipNotification;

  bool _canSignInWithApple;
  bool get canSignInWithApple => _canSignInWithApple;

  PlankModel({
    @required this.repository,
    @required this.challengeRepo,
    @required this.credentialsRepo,
    @required this.userRepo,
    @required this.mobileRepo,
  })  : _isLoading = false,
        _isError = false,
        _loggedIn = false,
        _history = [],
        _challenges = [],
        _challenge = Challenge.empty(),
        _currentChallengeUUID = "",
        _showChallenge = true,
        _challengeNotificationShownOnCreate = false,
        _challengeNotificationShownOnJoin = false,
        _challengeNotificationShownOnPlank = false,
        _challengeNotificationShownWithChallenges = false,
        _offline = false,
        _showIntervals = false,
        _intervalTime = 0,
        _bootstrapping = true,
        _bootstrapped = false,
        _bootstrapLogin = false,
        _displayName = "",
        _showCallToActionForDisplayName = true,
        _skipNotification = false,
        _canSignInWithApple = false;

  _notifyListeners() {
    print(
        "_notifyListeners _bootstrapping=$_bootstrapping, _skipNotification=$_skipNotification");
    if (_bootstrapping) {
      return;
    }

    if (_skipNotification) {
      return;
    }

    notifyListeners();
  }

  bool _checkErrorForOffline(dynamic err) {
    if (err.runtimeType == SocketException) {
      if (err.toString().contains("Connection refused")) {
        _offline = true;
        _notifyListeners();
        return true;
      }
    }
    return false;
  }

  bool _checkErrorFor403(dynamic err) {
    if (err.runtimeType == ApiException) {
      if ((err as ApiException).code == 403) {
        _loggedIn = false;
        _notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<void> bootstrap() async {
    _bootstrapping = true;
    await _loadCredentials();
    if (_credentials.idpGoogleEnabled()) {
      // This gets reloaded needs protection
      // The listener will update credentials.idpGoogle
      _bootstrapGoogleSignIn();
    }

    if (_credentials.idpAppleEnabled()) {
      await _bootstrapAppleSignIn();
    }

    _loggedIn = credentialsRepo.isLoggedIn();

    await _loadState();

    _bootstrapping = false;
    _bootstrapped = true;
    _bootstrapLogin = _loggedIn;
    _notifyListeners();
  }

  Future<void> _loadState() async {
    await loadSettings();
    await loadHistory();
    await loadChallenges();
    await loadCurrentChallenge();
    // if currentChallengeUUID
    // getChallengeWithHistory
  }

  Future<void> loadSettings() async {
    var prefs = await SharedPreferences.getInstance();
    _intervalTime = prefs.getInt("plank.settings.intervalTime");
    _showIntervals = prefs.getBool("plank.settings.showIntervals");
    _showChallenge = prefs.getBool("plank.settings.showChallenge");

    _challengeNotificationShownOnCreate =
        prefs.getBool("plank.settings.challengeNotificationShown.onCreate");
    _challengeNotificationShownOnJoin =
        prefs.getBool("plank.settings.challengeNotificationShown.onJoin");
    _challengeNotificationShownOnPlank =
        prefs.getBool("plank.settings.challengeNotificationShown.onPlank");
    _challengeNotificationShownWithChallenges = prefs
        .getBool("plank.settings.challengeNotificationShown.withChallenges");

    _currentChallengeUUID =
        prefs.getString("plank.settings.currentChallengeUUID");

    _previousChallengeUUID =
        prefs.getString("plank.settings.previousChallengeUUID");

    _appPushNotifications =
        prefs.getBool("plank.settings.notificationsEnabled");
    _appPushNotificationsShown =
        prefs.getBool("plank.settings.notificationsShown");

    if (_intervalTime == null) {
      _intervalTime = 0;
    }

    if (_showIntervals == null) {
      _showIntervals = false;
    }

    if (_showChallenge == null) {
      _showChallenge = true;
    }

    if (_challengeNotificationShownOnCreate == null) {
      _challengeNotificationShownOnCreate = false;
    }

    if (_challengeNotificationShownOnJoin == null) {
      _challengeNotificationShownOnJoin = false;
    }

    if (_challengeNotificationShownOnPlank == null) {
      _challengeNotificationShownOnPlank = false;
    }

    if (_challengeNotificationShownWithChallenges == null) {
      _challengeNotificationShownWithChallenges = false;
    }

    if (_currentChallengeUUID == null) {
      _currentChallengeUUID = "";
    }

    if (_previousChallengeUUID == null) {
      _previousChallengeUUID = "";
    }

    if (_appPushNotifications == null) {
      _appPushNotifications = false;
    }

    if (_appPushNotificationsShown == null) {
      _appPushNotificationsShown = false;
    }

    // Double check whats in the preferences
    bool actual = await getNotificationPermission();
    if (actual != _appPushNotifications) {
      await prefs.setBool("plank.settings.notificationsEnabled", actual);
      _appPushNotifications = actual;
    }

    if (_appPushNotifications) {
      if (!_appPushNotificationsShown) {
        await prefs.setBool("plank.settings.notificationsShown", true);
        _appPushNotificationsShown = true;
      }
    }

    _canSignInWithApple = await SignInWithApple.isAvailable();
  }

  Future<void> loadHistory() async {
    if (!_loggedIn) {
      return;
    }

    try {
      // TODO is it possible to get the challenge from here? I dont think so.
      var loadedEntries = await repository.history();
      _history = loadedEntries;
      _notifyListeners();
    } catch (error) {
      _lastError = error;
      _checkErrorFor403(error);
      _checkErrorForOffline(error);
    }
  }

  Future<void> addEntry(Plank record) async {
    try {
      await repository.addEntry(record, _challenge.uuid);

      if (_challenge.uuid.isNotEmpty) {
        _skipNotification = true;
        await getChallengeWithHistory(_challenge.uuid);
        _skipNotification = false;
      }

      await loadHistory();
    } catch (error) {
      _lastError = error;
      _isLoading = false;
      _skipNotification = false;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      _notifyListeners();
    }
  }

  Future<void> deleteEntryFromHistory(String recordUUID) async {
    try {
      await repository.deleteEntry(recordUUID);
      await loadHistory();
    } catch (error) {
      _lastError = error;
      _isLoading = false;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      _notifyListeners();
    }
  }

  // Delete from challenge + history
  Future<void> deleteEntryFromChallenge(
      String challengeUUID, String recordUUID) async {
    try {
      await repository.deleteEntry(recordUUID);
      await getChallengeWithHistory(challengeUUID);
    } catch (error) {
      _lastError = error;
      _isLoading = false;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      _notifyListeners();
    }
  }

  Future<void> setShowIntervals(bool newValue) async {
    _showIntervals = newValue;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("plank.settings.showIntervals", _showIntervals);
    _notifyListeners();
  }

  Future<void> setIntervalTime(int newValue) async {
    _intervalTime = newValue;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("plank.settings.intervalTime", _intervalTime);
    _notifyListeners();
  }

  Future<void> setShowChallenge(bool newValue) async {
    _showChallenge = newValue;
    _challenge = Challenge.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("plank.settings.showChallenge", _showChallenge);
    _notifyListeners();
  }

  Future<void> setShownChallengeNotification(
      String action, bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (action) {
      case "onCreate":
        _challengeNotificationShownOnCreate = newValue;
        await prefs.setBool(
            "plank.settings.challengeNotificationShown.onCreate",
            _challengeNotificationShownOnCreate);
        break;
      case "onJoin":
        _challengeNotificationShownOnJoin = newValue;
        await prefs.setBool("plank.settings.challengeNotificationShown.onJoin",
            _challengeNotificationShownOnJoin);
        break;
      case "onPlank":
        _challengeNotificationShownOnPlank = newValue;
        await prefs.setBool("plank.settings.challengeNotificationShown.onPlank",
            _challengeNotificationShownOnPlank);
        break;
      case "withChallenges":
        _challengeNotificationShownWithChallenges = newValue;
        await prefs.setBool(
            "plank.settings.challengeNotificationShown.withChallenges",
            _challengeNotificationShownWithChallenges);
        break;
      default:
        print("setShownChallengeNotification action, not supported");
        return;
    }

    _notifyListeners();
  }

  Future<void> setChallenge(Challenge newValue) async {
    if (_currentChallengeUUID.isNotEmpty) {
      _previousChallengeUUID = _currentChallengeUUID;
    }

    _challenge = newValue;
    _currentChallengeUUID = newValue.uuid;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Future.wait([
      prefs.setString(
          "plank.settings.currentChallengeUUID", _currentChallengeUUID),
      prefs.setString(
          "plank.settings.previousChallengeUUID", _previousChallengeUUID),
    ]);

    _notifyListeners();
  }

  Future<bool> addChallenge(BuildContext context, Challenge challenge) async {
    bool success = true;
    try {
      ChallengeInput input = ChallengeInput();
      input.kind = "plank-group";
      input.description = challenge.description;

      ChallengeShortInfo response = await challengeRepo.createChallenge(input);
      _challenges.insert(
          0, Challenge(uuid: response.uuid, description: response.description));
    } catch (error) {
      _checkErrorForOffline(error);

      print("Issue adding challenge plankmodel.addChallenge error $error");
      if (error is ApiException) {
        if (error.code == 403) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.GROUNDED,
            title: "Error",
            message: "The username or password is wrong",
            duration: Duration(seconds: 5),
            blockBackgroundInteraction: true,
          )..show(context);
        }
      }
      success = false;
    }

    _notifyListeners();
    return success;
  }

  Future<bool> joinChallenge(String uuid) async {
    try {
      bool joined = await challengeRepo.joinChallenge(uuid);
      if (!joined) {
        return false;
      }

      await loadChallenges();
      return true;
    } catch (error) {
      _lastError = error;
      _checkErrorFor403(error);
      _checkErrorForOffline(error);
      return false;
    }
  }

  Future<bool> leaveChallenge(String uuid) async {
    try {
      await challengeRepo.leaveChallenge(uuid);

      var index = _challenges.indexWhere((element) => element.uuid == uuid);
      if (index != -1) {
        _challenges.removeAt(index);
        setChallenge(Challenge.empty());
      }

      return true;
    } catch (error) {
      _lastError = error;
      _checkErrorFor403(error);
      _checkErrorForOffline(error);
      return false;
    }
  }

  Future<void> loadChallenges() async {
    if (!_loggedIn) {
      return;
    }

    try {
      var temp =
          await challengeRepo.getChallengesByUser(_credentials.login.userUuid);

      _challenges = temp.map((ChallengeShortInfo challenge) {
        return Challenge(
            uuid: challenge.uuid, description: challenge.description);
      }).toList();
      _notifyListeners();
    } catch (error) {
      _challenges = [];
      _lastError = error;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
    }

    return;
  }

  Future<void> loadCurrentChallenge() async {
    if (!_loggedIn) {
      return;
    }

    if (currentChallengeUUID == "") {
      return;
    }

    await getChallengeWithHistory(currentChallengeUUID);
    return;
  }

  Future<void> getChallengeWithHistory(String uuid) async {
    try {
      var challenge = await challengeRepo.getChallenge(uuid);
      setChallenge(Challenge(
        uuid: challenge.uuid,
        description: challenge.description,
        users: challenge.users,
        records: challenge.records,
      ));
    } catch (error) {
      // TODO possibly can error because the challenge is removed
      _lastError = error;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      _notifyListeners();
    }
  }

  Future<void> _loadCredentials() async {
    var credentials = await credentialsRepo.loadCredentials();
    _credentials = credentials;
    _notifyListeners();
  }

  // User model

  Future<bool> setDisplayName(String newValue) async {
    try {
      var success =
          await userRepo.setDisplayName(_credentials.login.userUuid, newValue);
      return success;
    } catch (error) {
      _lastError = error;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      return false;
    }
  }

  Future<void> setShowCallToActionForDisplayName(bool newValue) async {
    _showCallToActionForDisplayName = newValue;
    _notifyListeners();
  }

  // Handle when  the notification is challenge:updated
  // Get challenge
  // Set challenge
  // Update index for the screen
  // await plankModel.notificationChallengeUpdated(challengeUUID)

  // Start at the plank screen

  String _notificationAction = "";
  String get notificationAction => _notificationAction;

  String _latestNotificationId = "";
  String get latestNotificationId => _latestNotificationId;

  String _lastNotificationId = "";
  String get lastNotificationId => _lastNotificationId;

  Future<void> notificationChallengeUpdated(
      String messageId, String uuid) async {
    _skipNotification = true;
    await getChallengeWithHistory(uuid);
    // Not yet needing fine grain actions
    _notificationAction = "challenge.updated";
    _lastNotificationId = _latestNotificationId;
    _latestNotificationId = messageId;
    _skipNotification = false;
    _notifyListeners();
  }

  // ----
  Future<void> _handleGoogleSignIn(GoogleSignInAccount account) async {
    _credentials.idpGoogle = account;
    if (_credentials.idpGoogle == null) {
      _loggedIn = false;
      _bootstrapLogin = false;
      _notifyListeners();
      return;
    }

    HttpUserLoginIDPInput input = HttpUserLoginIDPInput();

    var auth = await _credentials.idpGoogle.authentication;
    input.idp = CredentialsLoginTypeGoogle;
    input.idToken = auth.idToken;

    try {
      var session =
          await credentialsRepo.loginWithIdp(input, learnalistEnv.basePath);

      var newCredentials = Credentials();
      newCredentials.login = session;
      newCredentials.loginType = CredentialsLoginTypeGoogle;

      await credentialsRepo.saveCredentials(
          newCredentials, learnalistEnv.basePath);
      await _loadCredentials();

      _loggedIn = credentialsRepo.isLoggedIn();
      // Need to add it back as the credentials are reloaded.
      _credentials.idpGoogle = account;
      _skipNotification = true;
      await _loadState();

      String token = await getToken();
      sendTokenToServer(token);

      _skipNotification = false;
      _bootstrapLogin = true;
      _notifyListeners();
    } catch (error) {
      _skipNotification = false;
      var newCredentials = Credentials.defaultValues();
      await credentialsRepo.saveCredentials(
          newCredentials, learnalistEnv.basePath);
      _lastError = error;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
    }
  }

  Future<void> _handleAppleSignIn(AuthorizationCredentialAppleID auth) async {
    HttpUserLoginIDPInput input = HttpUserLoginIDPInput();

    input.idp = CredentialsLoginTypeApple;
    input.idToken = auth.identityToken;
    input.code = auth.authorizationCode;

    try {
      var session =
          await credentialsRepo.loginWithIdp(input, learnalistEnv.basePath);

      var newCredentials = Credentials();
      newCredentials.login = session;
      newCredentials.loginType = CredentialsLoginTypeApple;
      newCredentials.idpApple = auth.userIdentifier;

      await credentialsRepo.saveCredentials(
          newCredentials, learnalistEnv.basePath);
      await _loadCredentials();

      _loggedIn = credentialsRepo.isLoggedIn();
      // We store the user identifier, meaning we dont need to reload
      _skipNotification = true;
      await _loadState();

      String token = await getToken();
      sendTokenToServer(token);

      _skipNotification = false;
      _bootstrapLogin = true;
      _notifyListeners();
    } catch (error) {
      _skipNotification = false;
      var newCredentials = Credentials.defaultValues();
      await credentialsRepo.saveCredentials(
          newCredentials, learnalistEnv.basePath);
      _lastError = error;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    if (_credentials.idpGoogle != null) {
      await _googleSignIn.disconnect();
    }

    await credentialsRepo.unloadCredentials();

    _credentials = Credentials.defaultValues();

    // Add logout to the site
    _loggedIn = false;
    _isLoading = false;
    _notifyListeners();
  }

  Future<void> loginWithUsername(
      HttpUserLoginRequest input, String serverBasePath) async {
    return credentialsRepo
        .loginWithUsername(input, serverBasePath)
        .then((session) async {
      // Maybe pass in
      var newCredentials = Credentials.defaultValues();
      newCredentials.login = session;
      newCredentials.loginType = CredentialsLoginTypeUsername;
      await credentialsRepo.saveCredentials(newCredentials, serverBasePath);

      _skipNotification = true;
      await _loadCredentials();
      _loggedIn = credentialsRepo.isLoggedIn();
      await _loadState();

      String token = await getToken();
      sendTokenToServer(token);

      _bootstrapLogin = true;
      _skipNotification = false;
      _notifyListeners();
    }).catchError((error) async {
      _skipNotification = false;
      var newCredentials = Credentials.defaultValues();
      await credentialsRepo.saveCredentials(newCredentials, serverBasePath);
      _lastError = error;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      throw error;
    });
  }

  Future<void> loginWithGoogle() async {
    try {
      var account = await _googleSignIn.signIn();
      _skipNotification = true;
      await _handleGoogleSignIn(account);
      _skipNotification = false;
      _notifyListeners();
    } catch (error) {
      _skipNotification = false;
      var newCredentials = Credentials.defaultValues();
      await credentialsRepo.saveCredentials(
          newCredentials, learnalistEnv.basePath);
      _lastError = error;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
    }
  }

  void _bootstrapGoogleSignIn() {
    if (!_credentials.idpGoogleEnabled()) {
      print("idp:google not enabled");
      return;
    }

    _googleSignIn.onCurrentUserChanged.listen(_handleGoogleSignIn);

    _googleSignIn.signInSilently();
    print("idp:google enabled and setup");
  }

  Future<void> loginWithApple() async {
    try {
      _skipNotification = true;
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [],
      );

      await _handleAppleSignIn(credential);
      _skipNotification = false;
      _notifyListeners();
    } catch (error) {
      _skipNotification = false;
      var newCredentials = Credentials.defaultValues();
      await credentialsRepo.saveCredentials(
          newCredentials, learnalistEnv.basePath);
      _lastError = error;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
    }
  }

  Future<void> _bootstrapAppleSignIn() async {
    if (!_credentials.idpAppleEnabled()) {
      return;
    }

    final state =
        await SignInWithApple.getCredentialState(_credentials.idpApple);
    if (state != CredentialState.authorized) {
      await credentialsRepo.unloadCredentials();
      await _loadCredentials();
      return;
    }
  }

  Future<void> sendTokenToServer(String token) async {
    if (!loggedIn) {
      return;
    }

    try {
      await mobileRepo.registerDevice(token);
    } catch (error) {
      _lastError = error;
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
    }
    return;
  }

  bool _appPushNotifications = false;
  bool get appPushNotifications => _appPushNotifications;

  bool _appPushNotificationsShown = false;
  bool get appPushNotificationsShown => _appPushNotificationsShown;

  Future<void> setPushNotifications(bool state) async {
    _appPushNotifications = state;
    _appPushNotificationsShown = _appPushNotifications;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Future.wait([
      prefs.setBool(
          "plank.settings.notificationsShown", _appPushNotificationsShown),
      prefs.setBool(
          "plank.settings.notificationsEnabled", _appPushNotifications),
    ]);

    if (!_appPushNotifications) {
      _challengeNotificationShownOnCreate = false;
      _challengeNotificationShownOnJoin = false;
      _challengeNotificationShownOnPlank = false;
      _challengeNotificationShownWithChallenges = false;

      await Future.wait([
        prefs.setBool(
            "plank.settings.challengeNotificationShown.onCreate", false),
        prefs.setBool(
            "plank.settings.challengeNotificationShown.onJoin", false),
        prefs.setBool(
            "plank.settings.challengeNotificationShown.onPlank", false),
        prefs.setBool(
            "plank.settings.challengeNotificationShown.withChallenges", false),
      ]);
    }

    _notifyListeners();
  }
}
