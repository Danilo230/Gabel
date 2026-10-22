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
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      identityCard: json['identityCard'] as String,
      token: json['token'] as String,
      roles: List<String>.from(json['roles'] as List<dynamic>),
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