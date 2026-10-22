class TokenModel {

  final int userId;
  final String userName;
  final String identityCard;
  final String token;
  final Iterable<String> roles;

  TokenModel({
    required this.userId,
    required this.userName,
    required this.identityCard,
    required this.token,
    required this.roles,
  });

  static TokenModel fromJson(Map<String, dynamic> json){
    return TokenModel(
      userId: json['userId'],
      userName: json['userName'],
      identityCard: json['identityCard'],
      token: json['token'],
      roles: List<String>.from(json['roles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'identityCard': identityCard,
      'token': token,
      'roles': roles.toList(),
    };
  }
}