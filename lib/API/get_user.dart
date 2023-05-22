import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';

import 'post_login.dart';

class User {
  final int id;
  final String? password;
  final String email;
  final int sex;
  final String? avatar;
  final String? birthday;
  final int is_admin;
  final int confirm_mail;
  final String second_name;
  final String name;
  final String phone;
  final String city;
  final String? avatar_orig;
  final int confirm_phone;

  User(
    this.id,
    this.password,
    this.email,
    this.sex,
    this.avatar,
    this.birthday,
    this.is_admin,
    this.confirm_mail,
    this.second_name,
    this.name,
    this.phone,
    this.city,
    this.avatar_orig,
    this.confirm_phone,
  );
}

Future<User?> fetchUser(String token) async {
  final dio = Dio();
  final User user;
  final response = await dio.get('https://api-dev.lorety.com/v2/profile/',
      data: {},
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ));
  if (response.statusCode == 200) {
    try {
      user = User(
        response.data['id'],
        response.data['password'],
        response.data['email'],
        response.data['sex'],
        response.data['avatar'],
        response.data['birthday'],
        response.data['is_admin'],
        response.data['confirm_mail'],
        response.data['second_name'],
        response.data['name'],
        response.data['phone'],
        response.data['city'],
        response.data['avatar_orig'],
        response.data['confirm_phone'],
      );
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to GET ${response.statusCode}');
  }
  return null;
}
