class UserModel {
  final int userId;
  final String userName;
  final String identityCard;
  final bool userStatus;

  final String _password;
  final String _confirmPassword;

  UserModel({
    required this.userId,
    required this.userName,
    required this.identityCard,
    required this.userStatus,
  })  : _password = '',
        _confirmPassword = '';

  UserModel._createRequest({
    required this.userName,
    required this.identityCard,
    required String password,
    required String confirmPassword,
  })  : userId = 0,
        userStatus = true,
        _password = password,
        _confirmPassword = confirmPassword;

  UserModel._updateRequest({
    required this.userName,
    required this.identityCard,
    required this.userStatus,
    required String password,
    required String confirmPassword,
  })  : userId = 0,
        _password = password,
        _confirmPassword = confirmPassword;

  static UserModel fromCreateJson({
    required String userName,
    required String identityCard,
    required String password,
    required String confirmPassword,
  }) {
    return UserModel._createRequest(
      userName: userName,
      identityCard: identityCard,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  static UserModel fromUpdateJson({
    required String userName,
    required String identityCard,
    required bool userStatus,
    required String password,
    required String confirmPassword,
  }) {
    return UserModel._updateRequest(
      userName: userName,
      identityCard: identityCard,
      userStatus: userStatus,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      identityCard: json['identityCard'] as String,
      userStatus: json['userStatus'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'identityCard': identityCard,
      'userStatus': userStatus,
    };
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'userName': userName,
      'identityCard': identityCard,
      'password': _password,
      'confirmPassword': _confirmPassword,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'userName': userName,
      'identityCard': identityCard,
      'userStatus': userStatus,
      'password': _password,
      'confirmPassword': _confirmPassword,
    };
  }

  Map<String, dynamic> toDeleteJson() {
    return {
      'userStatus': false,
    };
  }
}