class UserModel {
  final int idUser;
  final String name;
  final String email;
  final String password;
  final String avatarUrl;
  final int role;

  UserModel({
    required this.idUser,
    required this.name,
    required this.email,
    required this.password,
    required this.avatarUrl,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    idUser: json['id_user'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
    avatarUrl: json['avatar_url'],
    role: json['role'],
  );

  Map<String, dynamic> toMap() => {
    'id_user': idUser,
    'name': name,
    'email': email,
    'password': password,
    'avatar_url': avatarUrl,
    'role': role,
  };
}
