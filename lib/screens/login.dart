import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';

import 'package:openapi/api.dart';

import 'package:the_humble_plank/plank_model.dart';

import 'package:the_humble_plank/screens/plank_shell.dart';
import 'package:the_humble_plank/widget/topbar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topBar(),
        body: Container(
            margin: const EdgeInsets.only(
                top: 100.0, bottom: 30.0, left: 30.0, right: 30.0),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              LoginForm(),
            ]))));
  }
}

class LoginForm extends StatefulWidget {
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
          if ((err as ApiException).code == 403) {
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
            mainButton: FlatButton(
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

      await context.read<PlankModel>().bootstrap();

      var curveTween = CurveTween(curve: Curves.easeIn);
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, animation, ___) => FadeTransition(
              opacity: animation.drive(curveTween), child: PlankShellScreen()),
          transitionDuration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginInfo loginInfo = defaultValues();
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
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
                  FlatButton(
                    focusNode: _submitFocus,
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
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
        ],
      ),
    );
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

  LoginInfo({
    @required this.basePath,
    @required this.username,
    @required this.password,
  });
}

LoginInfo defaultValues() {
  //return LoginInfo(
  //    username: "", password: "", basePath: "https://learnalist.net/api/v1");
  return LoginInfo(
      username: "iamtest1",
      password: "test123",
      basePath: "http://192.168.0.10:1234/api/v1");
}
