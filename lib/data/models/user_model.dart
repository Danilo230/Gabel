class UserModel {
  final int userId;
  final String userName;
  final String identityCard;
  final Iterable<String> roles;

  UserModel({
    required this.userId,
    required this.userName,
    required this.identityCard,
    required this.roles,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      identityCard: json['identityCard'] as String,
      roles: List<String>.from(json['roles'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'identityCard': identityCard,
      'roles': roles.toList(),
    };
  }
}

