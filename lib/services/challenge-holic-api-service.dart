import 'dart:convert';
import 'dart:io';

import 'package:challange_hollic_mobile_app/models/auth-token.model.dart';
import 'package:dio/dio.dart';

class ChallengeHolicApiService {
  static const String API_URL = 'http://192.168.1.14:3000/api/';

  ChallengeHolicApiService._internal();
  static final ChallengeHolicApiService _challengeHolicApiService = ChallengeHolicApiService._internal();

  static ChallengeHolicApiService get get => _challengeHolicApiService;
  final Dio _dio = Dio();

  Future<AuthToken> localSingup(String username, String email, String password, File? profile) async {
    String requestUrl ='${API_URL}auth/local/signup';
    final FormData formData = FormData.fromMap({
      'username': username,
      'email': email,
      'password': password,
      'profile_image': profile != null ? await MultipartFile.fromFile(profile.path) : null
    });
    try {
      final response = await _dio.post(requestUrl, data: formData);

      if (response.statusCode == HttpStatus.created) {
        return AuthToken.fromMap(response.data['tokens']);
      }
    } on DioError catch(e) {
      throw Exception(e.response!.data['message']);
    }
    throw Exception("Something went wrong when signing up");
  }

  Future<AuthToken> localSignin(String username, String password) async {
    String requestUrl ='${API_URL}auth/local/signin';
    try {
      final response = await _dio.post(requestUrl, data: {
        'username': username,
        'email': username,
        'password': password,
      });
      if (response.statusCode == HttpStatus.ok) {
        return AuthToken.fromMap(response.data['tokens']);
      }
    } on DioError catch(e) {
      throw Exception(e.response!.data['message']);
    }
    throw Exception("Something went wrong when signing in");
  }
}