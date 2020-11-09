import 'dart:collection';
import 'dart:core';
import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:openapi/api.dart';
import 'package:the_humble_plank/credentials_repository.dart';
import 'package:the_humble_plank/learnalist/challenge.dart';
import 'package:the_humble_plank/learnalist/dialog_error.dart';
import 'package:the_humble_plank/plank_repository.dart';
import 'package:the_humble_plank/challenge_repository.dart';
import 'package:the_humble_plank/user_repository.dart';

class PlankModel extends ChangeNotifier {
  final PlankRepository repository;
  final ChallengeRepository challengeRepo;
  final CredentialsRepository credentialsRepo;
  final UserRepository userRepo;

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

  PlankModel(
      {@required this.repository,
      @required this.challengeRepo,
      @required this.credentialsRepo,
      @required this.userRepo})
      : _isLoading = false,
        _isError = false,
        _loggedIn = false,
        _history = [],
        _challenges = [],
        _challenge = Challenge.empty(),
        _showChallenge = false,
        _offline = false,
        _showIntervals = false,
        _intervalTime = 0,
        _bootstrapping = true,
        _bootstrapped = false,
        _bootstrapLogin = false,
        _displayName = "",
        _showCallToActionForDisplayName = true;

  _notifyListeners() {
    if (_bootstrapping) {
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
    await loadCredentials();
    _loggedIn = _credentials.login.token != "" ? true : false;

    await loadSettings();
    await loadHistory();
    await loadChallenges();

    _bootstrapping = false;
    _bootstrapped = true;
    _bootstrapLogin = _loggedIn;
    print(
        "bootstrap $_loggedIn 2 ${_credentials.login.token} $_bootstrapLogin");
    _notifyListeners();
  }

  Future<void> loadSettings() async {
    var prefs = await SharedPreferences.getInstance();
    _intervalTime = prefs.getInt("plank.settings.intervalTime");
    _showIntervals = prefs.getBool("plank.settings.showIntervals");
    _showChallenge = prefs.getBool("plank.settings.showChallenge");

    if (_intervalTime == null) {
      _intervalTime = 0;
    }

    if (_showIntervals == null) {
      _showIntervals = false;
    }

    if (_showChallenge == null) {
      _showChallenge = true;
    }
  }

  Future<void> loadHistory() async {
    try {
      var loadedEntries = await repository.history();
      _history = loadedEntries;
      _notifyListeners();
    } catch (error) {
      _checkErrorFor403(error);
      _checkErrorForOffline(error);
      _lastError = error;
    }
  }

  Future<void> addEntry(Plank record) async {
    try {
      await repository.addEntry(record, _challenge.uuid);
      _challenge = Challenge(uuid: "", description: "");
      await loadHistory();
    } catch (error) {
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      _lastError = error;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setShowIntervals(bool newValue) async {
    _showIntervals = newValue;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("plank.settings.showIntervals", _showIntervals);
    notifyListeners();
  }

  Future<void> setIntervalTime(int newValue) async {
    _intervalTime = newValue;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("plank.settings.intervalTime", _intervalTime);
    notifyListeners();
  }

  Future<void> setShowChallenge(bool newValue) async {
    _showChallenge = newValue;
    _challenge = Challenge.empty();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("plank.settings.showChallenge", _showChallenge);
    notifyListeners();
  }

  Future<void> setChallenge(Challenge newValue) async {
    _challenge = newValue;
    notifyListeners();
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

    notifyListeners();
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
      _checkErrorFor403(error);
      _checkErrorForOffline(error);
      _lastError = error;

      return false;
    }
  }

  Future<bool> leaveChallenge(String uuid) async {
    try {
      await challengeRepo.leaveChallenge(uuid);

      var index = _challenges.indexWhere((element) => element.uuid == uuid);
      if (index != -1) {
        _challenges.removeAt(index);
        setChallenge(Challenge(
            uuid: challenge.uuid, description: challenge.description));
      }
      return true;
    } catch (error) {
      _checkErrorFor403(error);
      _checkErrorForOffline(error);
      _lastError = error;

      return false;
    }
  }

  Future<void> loadChallenges() async {
    //_challenges = [
    //  Challenge(uuid: "fake-123", description: "Daily plank"),
    //  Challenge(uuid: "fake-456", description: "Group plank"),
    //];

    try {
      var temp =
          await challengeRepo.getChallengesByUser(_credentials.login.userUuid);

      _challenges = temp.map((ChallengeShortInfo challenge) {
        return Challenge(
            uuid: challenge.uuid, description: challenge.description);
      }).toList();
    } catch (error) {
      _checkErrorFor403(error);
      _checkErrorForOffline(error);
      _challenges = [];
      _lastError = error;
    }

    _notifyListeners();
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
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      _lastError = error;
      notifyListeners();
    }
  }

  Future<void> loginWithUsername(
      HttpUserLoginRequest input, String serverBasePath) async {
    return credentialsRepo
        .loginWithUsername(input, serverBasePath)
        .then((loggedIn) async {
      await credentialsRepo.saveCredentials(loggedIn, serverBasePath);
      await loadCredentials();
    }).catchError((error) async {
      var loggedIn = HttpUserLoginResponse();
      loggedIn.token = "";
      loggedIn.userUuid = "";
      await credentialsRepo.saveCredentials(loggedIn, serverBasePath);

      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      _lastError = error;
      throw error;
    });
  }

  Future<void> loadCredentials() async {
    var credentials = await credentialsRepo.loadCredentials();
    _credentials = credentials;
    _notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    await credentialsRepo.unloadCredentials();
    _credentials = Credentials();
    _credentials.login.token = "";
    _credentials.login.userUuid = "";
    _credentials.serverBasePath = "";

    _isLoading = false;
    _notifyListeners();
  }

  // User model

  Future<bool> setDisplayName(String newValue) async {
    try {
      var success =
          await userRepo.setDisplayName(_credentials.login.userUuid, newValue);

      if (success) {
        _displayName = newValue;
        notifyListeners();
      }
      return success;
    } catch (error) {
      _checkErrorForOffline(error);
      _checkErrorFor403(error);
      _lastError = error;
      notifyListeners();
      return false;
    }
  }

  Future<void> setShowCallToActionForDisplayName(bool newValue) async {
    _showCallToActionForDisplayName = newValue;
    notifyListeners();
  }
}
