import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:temp_project/record_pages/meal.dart';
import 'package:temp_project/user_control/user_controller.dart';

class MealProvider with ChangeNotifier {
  //GET 함수
  Future<MealRecord> getMealRecord(int year, int month, int day) async {
    print("<<<기록 GET 실행>>>");

    String? token = await UserProvider().storage.read(key: 'token');
    print(token);

    final Parameters = {'year': year, 'month': month, 'day': day}
        .map((key, value) => MapEntry(key, value.toString()));

    var url = Uri.parse('http://52.78.205.224:8000/record/1/');

    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      //'Autorization': 'token $token'
      //"token":"18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c",
    };

    var newURI = url.replace(queryParameters: Parameters);
    print(newURI);
    var response = await http.get(newURI, headers: headers);

    print('response Code : ${response.statusCode}');
    // print(MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes))));

    if (response.statusCode == 200) {
      print('GET 성공');
      notifyListeners();
      return MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('GET 실패');
    }
  }

  //POST
  Future<void> postMealRecord(MealInfo mealInfo) async {
    print("<<<POST 실행>>>");

    var url = Uri.parse('http://52.78.205.224:8000/record/upload/1/');

    var body = json.encode(<String, dynamic>{
      'when': mealInfo.when,
      'category': mealInfo.category,
      'price': mealInfo.price,
      'memo': mealInfo.memo
    });

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Charset': 'utf-8',
          //'Autorization': 'token $token',
        },
        body: body);

    print("기록 Code: ${response.statusCode}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response);
      print("<<<기록 POST 성공>>>");
      //return MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('기록 POST 실패');
    }
  }
}
