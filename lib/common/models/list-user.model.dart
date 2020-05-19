class ListUserModel {
  final String id;
  final String username;
  final String role;
  final String createdAt;
  final String updatedAt;

  ListUserModel(
      {this.id, this.username, this.role, this.createdAt, this.updatedAt});

  factory ListUserModel.fromJson(Map<String, dynamic> data) {
    print('in listUser');
    return ListUserModel(
        id: data['_id'],
        username: data['username'],
        role: data['role'],
        createdAt: data['_createdAt'],
        updatedAt: data['_updatedAt']);
  }
}
