import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:openapi/api.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:thehumbleplank/env.dart';
import 'package:thehumbleplank/plank_model.dart';
import 'package:thehumbleplank/theme.dart';
import 'package:thehumbleplank/widget/topbar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var canSignInWithApple =
        context.select((PlankModel model) => model.canSignInWithApple);
    LoginInfo loginInfo = defaultValues();
    Widget body =
        Center(child: Image(image: AssetImage('assets/icon/icon.png')));

    var options = <Widget>[
      body,
      loginWithGoogle(context),
      if (canSignInWithApple) ...[loginWithApple(context)],
      if (loginInfo.env == "dev") ...[LoginForm(loginInfo: loginInfo)],
    ];

    return Scaffold(
        appBar: topBar(),
        body: Container(
            margin: const EdgeInsets.only(
                top: 0.0, bottom: 20.0, left: 30.0, right: 30.0),
            child: SingleChildScrollView(child: Column(children: options))));
  }

  Widget loginWithGoogle(BuildContext context) {
    final String assetName = 'assets/login/google.svg';
    final Widget svgIcon = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Google logo',
    );

    return Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black38),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
              overlayColor: MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(color: Colors.black38, width: 1)),
            ),
            onPressed: () async {
              await context.read<PlankModel>().loginWithGoogle();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                svgIcon,
                Text(
                  "Sign in with Google",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            )));
  }

  Widget loginWithApple(BuildContext context) {
    final String assetName = 'assets/login/apple.svg';
    final Widget svgIcon = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Apple logo',
    );

    return Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
              overlayColor: MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(color: Colors.black, width: 1)),
            ),
            onPressed: () async {
              await context.read<PlankModel>().loginWithApple();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                svgIcon,
                Text(
                  "Sign in with Apple",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            )));
  }
}

class LoginForm extends StatefulWidget {
  final LoginInfo loginInfo;

  LoginForm({this.loginInfo});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  FocusNode _usernameFocus;
  FocusNode _passwordFocus;
  FocusNode _submitFocus;
  HttpUserLoginRequest _loginInput = HttpUserLoginRequest();
  String _serverBasePath;

  @override
  void initState() {
    super.initState();
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
    _submitFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    _usernameFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  void validateform(BuildContext context) async {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await context
            .read<PlankModel>()
            .loginWithUsername(_loginInput, _serverBasePath);
      } catch (err) {
        if (err is ApiException) {
          if (err.code == 403) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.GROUNDED,
              title: "Error",
              message: "The username or password is wrong",
              duration: Duration(seconds: 5),
              blockBackgroundInteraction: true,
            )..show(context);
          }
        } else {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.GROUNDED,
            title: "Error",
            message: "Something has gone wrong",
            blockBackgroundInteraction: true,
            mainButton: TextButton(
              onPressed: () {
                context.read<PlankModel>().logout();
                Phoenix.rebirth(context);
              },
              child: Text(
                "Click to restart",
                style: TextStyle(color: Colors.amber),
              ),
            ),
          )..show(context);
        }
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var options = <Widget>[
      loginWithUsername(widget.loginInfo),
    ];

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: options),
    );
  }

  Widget loginWithUsername(LoginInfo loginInfo) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Label(title: "Username"),
          TextFormField(
            autocorrect: false,
            focusNode: _usernameFocus,
            initialValue: loginInfo.username,
            decoration: _inputTheme(hint: "Username or email"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            onSaved: (value) {
              _loginInput.username = value;
            },
          ),
          _Label(title: "Password"),
          TextFormField(
            initialValue: loginInfo.password,
            obscureText: true,
            autocorrect: false,
            focusNode: _passwordFocus,
            decoration: _inputTheme(hint: "Password to use"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your password';
              }

              return null;
            },
            onSaved: (value) {
              _loginInput.password = value;
            },
          ),
          _Label(title: "Server"),
          TextFormField(
            initialValue: loginInfo.basePath,
            autocorrect: false,
            decoration: _inputTheme(hint: loginInfo.basePath),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please server base path';
              }

              return null;
            },
            onSaved: (value) {
              _serverBasePath = value;
            },
          ),
          Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    focusNode: _submitFocus,
                    style: primaryButtonStyle(),
                    onPressed: () {
                      validateform(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              )),
        ]);
  }
}

class _Label extends StatelessWidget {
  const _Label({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )));
  }
}

InputDecoration _inputTheme({String hint}) {
  InputDecoration decoration = InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
    border:
        new OutlineInputBorder(borderSide: new BorderSide(color: Colors.teal)),
  );

  return decoration;
}

class LoginInfo {
  final String basePath;
  final String username;
  final String password;
  final String env;

  LoginInfo({
    @required this.basePath,
    @required this.username,
    @required this.password,
    @required this.env,
  });
}

LoginInfo defaultValues() {
  var env = LearnalistEnv.defaultValues();
  return LoginInfo(
      username: env.username,
      password: env.password,
      basePath: env.basePath,
      env: env.env);
}
