import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:listylist/common/models/item.model.dart';
import 'package:listylist/common/models/list.model.dart';
import 'package:listylist/common/utils/auth.utils.dart';
import 'package:listylist/common/utils/constants.utils.dart';

class ItemHttpClient {
  Future<ListModel> updateItems(
      List<ItemModel> items, String listId) async {
    final response = await http.post(
      ConstantsUtils.SERVER_ADDRESS + '/items/',
      body: {
        "listId": listId,
        "items": items,
      },
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + await AuthUtils.getToken()
      },
    );
    if (response.statusCode < 400) {
      return ListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(json.decode(response.body));
    }
  }

  Future<ListModel> removeItem(String itemId, String listId) async {
    final response = await http.delete(
      ConstantsUtils.SERVER_ADDRESS + '/items/' + itemId + '/?from=' + listId,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + await AuthUtils.getToken()
      },
    );
    if (response.statusCode < 400) {
      return ListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(json.decode(response.body));
    }
  }
}
