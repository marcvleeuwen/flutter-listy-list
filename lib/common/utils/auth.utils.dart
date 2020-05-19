import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<String> saveToken(String authToken) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString('auth_token', authToken);
      return 'Successful';
    } catch (e) {
      return 'error' + e;
    }
  }

  static Future<bool> isAuthenticated() async {
    final String token = await AuthUtils.getToken();

    if (token != null) {
      final decodeToken = Jwt.parseJwt(token);
      final DateTime exp =
          new DateTime.fromMillisecondsSinceEpoch(decodeToken['exp'] * 1000);

      return exp.isAfter(new DateTime.now());
    } else {
      return false;
    }
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return await prefs.remove('auth_token');
    } catch (e) {
      throw Exception('error' + e);
    }
  }
}
