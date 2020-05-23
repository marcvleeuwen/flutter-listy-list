import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  void signUp() async {
    if (_formKey.currentState.validate()) {
      await ServiceFacade().createUser(_username, _email, _password);
      await ServiceFacade().login(_username, _password);
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  void togglePassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (!RegExp(ConstantsUtils.USERNAME_REGEX)
                        .hasMatch(value)) {
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
                    prefixIcon: new Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (String val) => setState(() => _username = val),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
                    prefixIcon: new Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (String val) => setState(() => _email = val),
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
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
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: new Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => togglePassword(),
                      child: new Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onChanged: (String val) => setState(() => _password = val),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Create',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    FlatButton(
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      textColor: Colors.white,
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xfff9d660),
                                Color(0xffee7228),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 5, bottom: 5),
                        child: Icon(Icons.arrow_forward),
                      ),
                      onPressed: signUp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
