class UserModel {
  final String userId;
  final String email;
  final String username;
  final DateTime createdAt;
  final int orderCount;
  final String? avatarUrl;
  final int learningModuleCount;
  final int role;

  UserModel({
    required this.userId,
    required this.email,
    required this.username,
    required this.createdAt,  
    this.orderCount = 0,
    this.avatarUrl,
    this.learningModuleCount = 0, 
    required this.role ,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      userId: docId,
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()  
          : DateTime.now(),  
      orderCount: map['orderCount'] ?? 0,
      avatarUrl: map['avatarUrl'],
      learningModuleCount: map['learningModuleCount'] ?? 0, 
      role: map['role'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'username': username,
      'createdAt': createdAt.toIso8601String(),  
      'orderCount': orderCount,
      'avatarUrl': avatarUrl,
      'learningModuleCount': learningModuleCount,
      'role': role,
    };
  }
}