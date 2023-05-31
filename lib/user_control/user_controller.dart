import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:temp_project/user_control/user.dart';

class UserProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  //GET 함수
  Future<UserInfo> getUserInfo() async {
    var url = Uri.parse('http://52.78.205.224:8000/user/login/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      //'Autorization': 'token $token'
      //"token":"18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c",
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print('LOGIN 성공');
      notifyListeners();
      return UserInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('LOGIN 실패');
    }
  }

  //로그인 POST
  Future<UserInfo> postUserInfo(String username, String password) async {
    print("<<<로그인 POST 실행>>>");

    var url = Uri.parse('http://52.78.205.224:8000/user/login/');

    var body = json.encode(<String, dynamic>{
      'password': password,
      'username': username,
    });

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Charset': 'utf-8',
          //'Autorization': 'token $token',
        },
        body: body);
    UserInfo userinfo =
        UserInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));

    await storage.write(key: 'token', value: userinfo.token);
    print("로그인 Code: ${response.statusCode}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("<<<로그인 POST 성공>>>");
      return userinfo;
    } else {
      throw Exception('<<<로그인 POST 실패>>>');
    }
  }

  //회원가입 POST
  Future<UserInfo> postNewUserInfo(
      String id, String pw, String name, String email) async {
    print("<<<회원가입 POST 실행>>>");

    var url = Uri.parse('http://52.78.205.224:8000/user/register/');

    var body = json.encode(<String, dynamic>{
      'password': pw,
      'username': name,
      'userid': id,
      'email': email
    });

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Charset': 'utf-8',
          //'Autorization': 'token $token',
        },
        body: body);
    print("회원가입 Code: ${response.statusCode}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.body);
      print("<<<회원가입 POST 성공>>>");
      return UserInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('<<<회원가입 POST 실패>>>');
    }
  }
}
