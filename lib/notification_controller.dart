import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:temp_project/notification.dart';
import 'package:temp_project/user_control/user_controller.dart';

class NotiProvider with ChangeNotifier {
  //GET 함수
  Future<List<Noti>> getNotification() async {
    print("<<<기부 알림 GET 실행>>>");

    String? token = await UserProvider().storage.read(key: 'token');
    print(token);

    var url = Uri.parse('http://52.78.205.224:8000/chat/user/notification/');

    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      //'Autorization': 'token $token'
      //"token":"18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c",
    };

    var response = await http.get(url, headers: headers);
    print(response.body);

    print('기부 알림 response Code : ${response.statusCode}');

    if (response.statusCode == 200) {
      print('기부 알림 GET 성공');
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Noti> allInfo =
          body.map((dynamic item) => Noti.fromJson(item)).toList();
      notifyListeners();
      //print(Noti.fromJson(json.decode(utf8.decode(response.bodyBytes))));
      return allInfo;
    } else {
      throw Exception('기록 GET 실패');
    }
  }
}
