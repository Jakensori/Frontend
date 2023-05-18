import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:temp_project/user_control/user.dart';

class UserProvider with ChangeNotifier {
  //GET 함수
  Future<UserInfo> getUserInfo() async {
    var url = Uri.parse('http://52.78.205.224:8000/user/login/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      //'Autorization': 'token $token'
      //"token":"18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c",
    };
    var response = await http.get(url, headers: headers);

    //print('response Code : ${response.statusCode}');
    //print(response);

    if (response.statusCode == 200) {
      print('LOGIN 성공');
      notifyListeners();
      return UserInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('LOGIN 실패');
    }
  }

  //POST
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

    print("로그인 Code: ${response.statusCode}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("<<<로그인 POST 성공>>>");
      return UserInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('<<<로그인 POST 실패>>>');
    }
  }
}
