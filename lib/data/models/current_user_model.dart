class CurrentUserModel {
  final int userId;
  final String userName;
  final String identityCard;
  final List<String> roles;

  const CurrentUserModel({
    required this.userId,
    required this.userName,
    required this.identityCard,
    required this.roles,
  });

  static CurrentUserModel fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      identityCard: json['identityCard'] as String,
      roles: (json['roles'] as List<dynamic>? ?? []).cast<String>(),
    );
  }
}

class UpdateProfileRequest {
  final String userName;
  final String? currentPassword;
  final String? newPassword;
  final String? confirmPassword;

  const UpdateProfileRequest({
    required this.userName,
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'userName': userName,
        if (newPassword != null) ...{
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
      };
}