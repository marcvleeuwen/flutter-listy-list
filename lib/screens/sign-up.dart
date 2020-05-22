import 'package:flutter/material.dart';
import 'package:listylist/common/services/facade.service.dart';
import 'package:listylist/common/utils/constants.utils.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email;
  String _username;
  String _password;
  final _formKey = GlobalKey<FormState>();

  void signUp() async {
    if (_formKey.currentState.validate()) {
      await ServiceFacade().createUser(_username, _email, _password);
      await ServiceFacade().login(_username, _password);
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (!RegExp(ConstantsUtils.USERNAME_REGEX).hasMatch(value)) {
                  return "Username can only contain alphanumeric character, - or _";
                }

                if (value.length == 0) {
                  return "Please provide a username";
                }

                if (value.length < 3) {
                  return "A username must have at least 3 characters";
                }

                return null;
              },
              autocorrect: false,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
              onChanged: (String val) => setState(() => _username = val),
            ),
            TextFormField(
              validator: (value) {
                if (!RegExp(ConstantsUtils.EMAIL_REGEX).hasMatch(value)) {
                  return "Invalid email";
                }

                if (value.length == 0) {
                  return "Please enter an email";
                }

                return null;
              },
              autocorrect: false,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (String val) => setState(() => _email = val),
            ),
            TextFormField(
              validator: (value) {
                if (value.length < 8) {
                  return "Password is too short";
                }

                if (value.length == 0) {
                  return "Please enter a password";
                }

                return null;
              },
              autocorrect: false,
              maxLines: 1,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              onChanged: (String val) => setState(() => _password = val),
            ),
            OutlineButton(
              child: Text('Sign up'),
              onPressed: signUp,
            ),
            new GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
              child: new Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
