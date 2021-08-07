import 'package:flutter/material.dart';

class LearnalistEnv {
  final String basePath;
  final String username;
  final String password;
  final String env;

  LearnalistEnv({
    @required this.basePath,
    @required this.username,
    @required this.password,
    @required this.env,
  });

  factory LearnalistEnv.defaultValues() {
    bool dev = true;
    if (!dev) {
      return LearnalistEnv(
          username: "",
          password: "",
          basePath: "https://learnalist.net/api/v1",
          env: "prod");
    }

    return LearnalistEnv(
        username: "iamtest1",
        password: "test123",
        basePath: "http://192.168.0.10:1234/api/v1",
        env: "dev");
  }
}
