import 'package:flutter/material.dart';
import 'package:listylist/common/services/facade.service.dart';
import 'package:listylist/common/utils/auth.utils.dart';
import 'package:listylist/screens/sign-up.dart';
import 'package:listylist/screens/splash.dart';

import 'screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/home': (context) => MyApp(),
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/sign-up': (context) => SignUpScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    AuthUtils.isAuthenticated();
    setState(() {
      _counter++;
    });
  }

  void _callService(String service) async {
    switch (service) {
      case 'login':
        print(await AuthUtils.isAuthenticated());
        print(await AuthUtils.getToken());
        break;
      case 'lists':
        ServiceFacade().getAllLists().then((res) {
          print(res);
        }).catchError((err) {
          print('getAllLists: ' + err);
        });
        break;
      case 'list':
        await ServiceFacade().getAllLists().then((res) {
          print(res);
        }).catchError((err) {
          print(err);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              onPressed: () {
                _callService('login');
              },
              child: new Text("login"),
            ),
            new RaisedButton(
              onPressed: () {
                _callService('lists');
              },
              child: new Text("get lists"),
            ),
            new RaisedButton(
              onPressed: () {
//                _callService('list');
                Navigator.pushReplacementNamed(context, '/splash');
              },
              child: new Text("splash test"),
            ),
          ],
        ),
      ),
    );
  }
}
