import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listylist/common/services/facade.service.dart';
import 'package:listylist/common/utils/auth.utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void whereToGo() async {
    final authenticated = await AuthUtils.isAuthenticated();
    if (authenticated) {
      final token = await AuthUtils.getToken();
      try {
        await ServiceFacade().jwtLogin(token);
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
