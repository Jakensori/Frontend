import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MealPoint {
  int? meal_point;
  int? level;

  MealPoint({
    required this.meal_point,
    required this.level,
  });

  factory MealPoint.fromJson(Map<String, dynamic> json) {
    return MealPoint(
      meal_point: json["meal_point"],
      level: json["level"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meal_point'] = this.meal_point;
    data['level'] = this.level;

    return data;
  }
}

Future<MealPoint> getInfo() async {
  print("<<<GET 실행>>>");

  //String? token = await UserProvider().storage.read(key: 'token');
  //print(token);

  var url = Uri.parse('http://52.78.205.224:8000/custom/mealpoint/1/');

  Map<String, String>? headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    //'Autorization': 'token $token'
    //"token":"18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c",
  };

  //var newURI = url.replace(queryParameters: Parameters);
  // print(newURI);
  var response = await http.get(url, headers: headers);

  print('기록 response Code : ${response.statusCode}');

  if (response.statusCode == 200) {
    print('기록 GET 성공');
    print(response.body);
    //notifyListeners();
    return MealPoint.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('기록 GET 실패');
  }
}
