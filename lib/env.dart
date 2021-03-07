import 'package:flutter/material.dart';

class LearnalistEnv {
  final String basePath;
  final String username;
  final String password;

  LearnalistEnv({
    @required this.basePath,
    @required this.username,
    @required this.password,
  });

  factory LearnalistEnv.defaultValues() {
    bool dev = false;
    if (!dev) {
      return LearnalistEnv(
          username: "",
          password: "",
          basePath: "https://learnalist.net/api/v1");
    }

    return LearnalistEnv(
        username: "iamtest1",
        password: "test123",
        basePath: "http://192.168.0.10:1234/api/v1");
  }
}
