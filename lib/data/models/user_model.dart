class UserModel {
  final int userid;
  final String username;
  final String passwordhash;
  final String userstatus;
  final String identitycard;

  UserModel({
      required this.userid,
      required this.username,
      required this.passwordhash,
      required this.userstatus,
      required this.identitycard,
    });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userid: json['userid'] as int,
      username: json['username'] as String,
      passwordhash: json['passwordhash'] as String,
      userstatus: json['userstatus'] as String,
      identitycard: json['identitycard'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'username': username,
      'passwordhash': passwordhash,
      'userstatus': userstatus,
      'identitycard': identitycard,
    };
  }
}