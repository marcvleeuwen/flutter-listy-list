import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:listylist/common/utils/auth.utils.dart';

import '../../models/list.model.dart';

class ListHttpClient {
  Future<List<ListModel>> getAllLists() async {
    final response = await http.get(
      'http://192.168.1.39:3030/lists/',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + await AuthUtils.getToken()
      },
    );
    if (response.statusCode < 400) {
      // parse the JSON and store only the 'data' array in the iterable
      Iterable res = json.decode(response.body)["data"];
      // loop over the parsed JSON and create a new list for each index
      return List<ListModel>.from(res.map((data) => ListModel.fromJson(data)));
    } else {
      throw Exception(json.decode(response.body));
    }
  }

  Future<ListModel> getList(String listId) async {
    final response = await http.get(
      'http://192.168.1.39:3030/lists/' + listId,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + await AuthUtils.getToken()
      },
    );

    if (response.statusCode < 400) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(json.decode(response.body));
    }
  }
}
