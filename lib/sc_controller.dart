import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class Ether {
  double? ether;
  Ether({required this.ether});

  factory Ether.fromJson(Map<String, dynamic> json) {
    return Ether(
      ether: json['ether'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ether'] = this.ether;

    return data;
  }
}

class EtherProvider with ChangeNotifier {
  //GET 함수
  Future<double?> getEther(int money) async {
    print("<<<이더 GET 실행>>>");

    //String? token = await UserProvider().storage.read(key: 'token');
    //print(token);

    var url = Uri.parse('http://52.78.205.224:8000/donation/change/${money}/');

    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      //'Autorization': 'token $token'
      //"token":"18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c",
    };

    var response = await http.get(url, headers: headers);
    var value = Ether.fromJson(json.decode(utf8.decode(response.bodyBytes)));

    print('이더 response Code : ${response.statusCode}');

    if (response.statusCode == 200) {
      print('이더 GET 성공');
      notifyListeners();

      return value.ether;
    } else {
      throw Exception('이더 GET 실패');
    }
  }
}
