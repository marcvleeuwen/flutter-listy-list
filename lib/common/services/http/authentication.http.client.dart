import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listylist/common/utils/auth.utils.dart';
import 'package:listylist/common/utils/constants.utils.dart';

class AuthenticationHttpClient {
  Future<void> login(String username, String password) async {
    var body;
    final bool emailValid =
        RegExp(ConstantsUtils.EMAIL_REGEX).hasMatch(username.toLowerCase());
    if (emailValid) {
      body = {"email": username, "password": password, "strategy": "email"};
    } else {
      body = {
        "username": username,
        "password": password,
        "strategy": "username"
      };
    }
    final response = await http
        .post(ConstantsUtils.SERVER_ADDRESS + '/authentication', body: body);
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
