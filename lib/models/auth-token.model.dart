class AuthToken {
  static const String API_REFRESH = 'refresh_token';
  static const String API_ACCESS = 'access_token';

  final String? access;
  final String? refresh;

  AuthToken({this.access, this.refresh});

  static AuthToken fromMap(Map<String, dynamic> map) {
    return AuthToken(access: map[API_ACCESS], refresh: map[API_REFRESH]);
  }
}