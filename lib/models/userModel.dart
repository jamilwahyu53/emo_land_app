class UserModel<T> {
  final String user_id;
  final String full_name;
  final String password;

  UserModel({
    this.user_id = "",
    this.full_name = "",
    this.password = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'full_name': full_name,
      'password': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user_id: json['user_id'] ?? '',
      password: json['password'] ?? '',
      full_name: json['full_name'] ?? '',
    );
  }

}
