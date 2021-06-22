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
    bool dev = false;
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
        basePath: "http://172.20.10.3:1234/api/v1",
        env: "dev");
  }
}
