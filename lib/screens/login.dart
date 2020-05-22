import 'package:flutter/material.dart';
import 'package:listylist/common/services/facade.service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;

  void signUp() {
    ServiceFacade().login(_email, _password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Login'),
            TextField(
              autocorrect: false,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username/Email',
              ),
            ),
            TextField(
              autocorrect: false,
              maxLines: 1,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            OutlineButton(
              child: Text('Login'),
              onPressed: () => {},
            ),
            new GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/sign-up");
              },
              child: new Text("Sign up"),
            )
          ],
        ),
      ),
    );
  }
}
