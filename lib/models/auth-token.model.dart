class AuthToken {
  final String? access;
  final String? refresh;

  AuthToken({this.access, this.refresh});

  static AuthToken fromMap(Map<String, dynamic> map) {
    return AuthToken(access: map['access_token'], refresh: map['refresh_token']);
  }
}