import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:temp_project/record_pages/meal.dart';

class MealProvider with ChangeNotifier {
  // MealRecord? _mealRecord;
  //MealRecord? get mealRecord => _mealRecord;
  String token =
      "18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c";
  //GET 함수
  Future<MealRecord> getMealRecord() async {
    var url = Uri.parse('http://52.78.205.224:8000/record/1/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      //'Autorization': 'token $token'
      //"token":"18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c",
    };
    var response = await http.get(url, headers: headers);

    print('response Code : ${response.statusCode}');
    print(response);

    if (response.statusCode == 200) {
      print(json.decode(utf8.decode(response.bodyBytes))); // 한글 깨짐 해결 !
      //  _mealRecord =  MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      //  _mealRecord =  MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      notifyListeners();
      return MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      throw Exception('계좌정보를 불러오는데 실패했습니다');
    }
  }

  //POST
  Future<MealInfo> postMealRecord(MealInfo mealInfo) async {
    var url = Uri.parse('http://52.78.205.224:8000/record/upload/');

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Autorization': 'token $token'
          //"token":"18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c"
        },
        body: json.encode(<String, dynamic>{
          'when': mealInfo.when,
          'category': mealInfo.category,
          'price': mealInfo.price,
          'memo': mealInfo.memo
        }));

    print('POST 응답');
    if (response.statusCode == 201 || response.statusCode == 200) {
      return MealInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('POST 실패');
    }
  }
}
