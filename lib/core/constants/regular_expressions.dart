class CommonRegex {
  static final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  static final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
}