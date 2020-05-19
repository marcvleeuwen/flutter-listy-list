import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listylist/common/utils/auth.utils.dart';

class AuthenticationHttpClient {
  Future<void> login(String username, String password) async {
    final response = await http.post('http://192.168.1.39:3030/authentication',
        body: {"username": username, "password": password, "strategy": "local"});
    if (response.statusCode < 400) {
      // parse the JSON and store only the 'data' array in the iterable
      String token = json.decode(response.body)["accessToken"];
      // loop over the parsed JSON and create a new list for each index
      AuthUtils.saveToken(token);
    } else {
      throw Exception(json.decode(response.body));
    }
  }
}
