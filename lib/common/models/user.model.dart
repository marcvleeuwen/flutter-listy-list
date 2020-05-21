class UserModel {

  final String id;
  final String email;
  final String username;
  final String avatar;
  final String password;
  final String createdAt;
  final String updatedAt;

  UserModel({this.id, this.email, this.username, this.avatar, this.password, this.createdAt, this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['_id'],
        email: json['email'],
        username: json['username'],
        avatar: json['avatar'],
        password: json['password'],
        createdAt: json['_createdAt'],
        updatedAt: json['_updatedAt']);
  }
}