import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:listylist/common/models/user.model.dart';
import 'package:listylist/common/utils/auth.utils.dart';

class UserHttpClient {
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(
      'http://192.168.1.39:3030/users/',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + await AuthUtils.getToken()
      },
    );
    if (response.statusCode < 400) {
      // parse the JSON and store only the 'data' array in the iterable
      Iterable res = json.decode(response.body)["data"];
      // loop over the parsed JSON and create a new list for each index
      return List<UserModel>.from(res.map((data) => UserModel.fromJson(data)));
    } else {
      throw Exception(json.decode(response.body));
    }
  }

  Future<UserModel> getUser(String userId) async {
    final response = await http.get(
      'http://192.168.1.39:3030/users/' + userId,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + await AuthUtils.getToken()
      },
    );
    if (response.statusCode < 400) {
      // parse the JSON and store only the 'data' array in the iterable
      Iterable res = json.decode(response.body)["data"];
      // loop over the parsed JSON and create a new list for each index
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(json.decode(response.body));
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(user.email.toLowerCase());
    bool usernameValid =
        RegExp(r"^[a-zA-Z0-9-_]+").hasMatch(user.username.toLowerCase());

    if (usernameValid && emailValid) {
      final response = await http.post(
        'http://192.168.1.39:3030/users/',
        body: {
          "email": user.email,
          "username": user.username,
          "password": user.password
        },
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ' + await AuthUtils.getToken()
        },
      );
      if (response.statusCode < 400) {
        // loop over the parsed JSON and create a new list for each index
        return UserModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(json.decode(response.body));
      }
    } else {
      final List error = [];
      if (!usernameValid) {
        error.add({
          "message": "Username can only contain numbers, characters, _ and -",
          "field": "username"
        });
      }
      if (!emailValid) {
        error.add({"message": "Invalid email address", "field": "email"});
      }

      throw Exception(error);
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    final response = await http.put(
      'http://192.168.1.39:3030/users/' + user.id,
      body: {
        "email": user.email,
        "username": user.username,
        "password": user.password,
        "avatar": user.avatar
      },
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + await AuthUtils.getToken()
      },
    );
    if (response.statusCode < 400) {
      // loop over the parsed JSON and create a new list for each index
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(json.decode(response.body));
    }
  }

  Future<void> removeUser(String userId) async {
    final response = await http.delete(
      'http://192.168.1.39:3030/users/' + userId,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + await AuthUtils.getToken()
      },
    );
    if (response.statusCode < 400) {
      return UserModel.fromJson(json.decode(response.body));
      ;
    } else {
      throw Exception(json.decode(response.body));
    }
  }
}
