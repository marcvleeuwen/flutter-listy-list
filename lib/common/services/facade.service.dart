import 'package:listylist/common/models/item.model.dart';
import 'package:listylist/common/models/list.model.dart';
import 'package:listylist/common/models/user.model.dart';
import 'package:listylist/common/services/http/authentication.http.client.dart';
import 'package:listylist/common/services/http/items.http.client.dart';
import 'package:listylist/common/services/http/users.http.client.dart';
import 'package:listylist/common/utils/auth.utils.dart';

import 'http/list.http.client.dart';

class ServiceFacade {
  // HTTP Services
  final authHttpClient = new AuthenticationHttpClient();
  final listHttpClient = new ListHttpClient();
  final userHttpClient = new UserHttpClient();
  final itemHttpClient = new ItemHttpClient();

  // Auth
  Future<void> login(String username, String password) async {
    return await authHttpClient.login(username, password);
  }

  Future<void> logout(String username, String password) async {
    return await AuthUtils.removeToken();
  }

  Future<bool> isAuthenticated(String username, String password) async {
    return await AuthUtils.isAuthenticated();
  }

  // List
  Future<List<ListModel>> getAllLists() async {
    return await listHttpClient.getAllLists();
  }

  Future<ListModel> getList(String listId) async {
    return await listHttpClient.getList(listId);
  }

  // Items
  Future<ListModel> updateItems(List<ItemModel> items, String listId) async {
    return await itemHttpClient.updateItems(items, listId);
  }

  Future<ListModel> removeItem(String itemId, String listId) async {
    return await itemHttpClient.removeItem(itemId, listId);
  }

  // Users
  Future<List<UserModel>> getUsers() async {
    return await userHttpClient.getUsers();
  }

  Future<UserModel> getUser(String userId) async {
    return await userHttpClient.getUser(userId);
  }

  Future<UserModel> updateUser(UserModel user) async {
    return await userHttpClient.updateUser(user);
  }

  Future<void> removeUser(String userId) async {
    return await userHttpClient.removeUser(userId);
  }
}
