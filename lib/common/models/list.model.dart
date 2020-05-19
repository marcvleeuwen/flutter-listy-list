import 'descriptor.model.dart';
import 'item.model.dart';
import 'list-user.model.dart';

class ListModel {
  final String id;
  final DescriptorModel details;
  final List<ItemModel> items;
  final List<ListUserModel> users;
  final String createdAt;
  final String updatedAt;

  ListModel(
      {this.id,
      this.details,
      this.items,
      this.users,
      this.createdAt,
      this.updatedAt});

  factory ListModel.fromJson(Map<String, dynamic> data) {
    if (data['details'] == null) {
      data['details'] = {'title': null, 'description': null};
    }
    if (data['items'] == null) {
      data['items'] = [];
    }
    if (data['users'] == null) {
      data['users'] = [];
    }
    return ListModel(
        id: data['_id'],
        details: DescriptorModel.fromJson(data['details']),
        items: List<ItemModel>.from(
            (data["items"]).map((item) => ItemModel.fromJson(item))),
        users: List<ListUserModel>.from(
            data['users'].map((user) => ListUserModel.fromJson(user))),
        createdAt: data['_createdAt'],
        updatedAt: data['_updatedAt']);
  }
}
