import 'dart:convert';
import 'package:dio/dio.dart';

class AuthToken {
  final String access_token;
  final String refresh_token;
  final String token_type;
  final int expire_timestamp;

  const AuthToken({
    required this.access_token,
    required this.refresh_token,
    required this.token_type,
    required this.expire_timestamp,
  });
}

Future<AuthToken?> fetchAuthToken(email, password) async {
  final dio = Dio();

  final response = await dio.post(
    'https://api-dev.lorety.com/v2/login/',
    options: Options(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    ),
    data: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    try {
      return AuthToken(
          access_token: response.data['access_token'],
          refresh_token: response.data['refresh_token'],
          token_type: response.data['token_type'],
          expire_timestamp: response.data['expire_timestamp']);
    } catch (e) {
      return null;
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load AuthToken  ${response.statusCode}');
  }
}
