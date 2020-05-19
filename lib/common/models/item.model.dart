import 'descriptor.model.dart';

class ItemModel {
  final String id;
  final DescriptorModel details;
  final String category;
  final String status;
  final String quantity;
  final String createdAt;
  final String updatedAt;

  ItemModel(
      {this.id,
      this.details,
      this.category,
      this.status,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  factory ItemModel.fromJson(Map<String, dynamic> data) {
    print('in item');
    if (data['details'] == null) {
      data['details'] = {'title': null, 'description': null};
    }
    return ItemModel(
        id: data['_id'],
        details: DescriptorModel.fromJson(data['details']),
        category: data['category'],
        status: data['status'],
        quantity: data['quantity'],
        createdAt: data['_createdAt'],
        updatedAt: data['_updatedAt']);
  }
}
