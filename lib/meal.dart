import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MealProvider with ChangeNotifier {
  MealRecord? _mealRecord;
  MealRecord? get mealRecord => _mealRecord;

  //GET 함수
  Future<MealRecord> fetchMealRecord() async {
    print("함수 들어옴");

    var url = Uri.parse('http://192.168.187.21:8000/record/2/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.get(url, headers: headers);
    print('GET 응답');

    if (response.statusCode == 200) {
      //만약 서버가 ok응답을 반환하면, json을 파싱합니다
      print('응답했다');
      print(json.decode(utf8.decode(response.bodyBytes))); // 한글 깨짐 해결 !
      _mealRecord =
          MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      _mealRecord =
          MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      notifyListeners();
      return MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      throw Exception('계좌정보를 불러오는데 실패했습니다');
    }
  }

  Future<http.Response> postMealRecord(MealInfo mealInfo) async {
    var url = Uri.parse('http://192.168.187.25:8000/record/upload');

    http.Response? response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: <String, dynamic>{
      'when': mealInfo.when,
      'category': mealInfo.category,
      'price': mealInfo.price,
      'memo': mealInfo.memo
    });
    print('POST 응답');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('POST 실패');
    }
  }
}

class MealInfo {
  String? when;
  String? category;
  int? price;
  String? memo;

  MealInfo(
      {required this.when,
      required this.category,
      required this.price,
      required this.memo});

  factory MealInfo.fromJson(Map<String, dynamic> json) {
    return MealInfo(
        when: json["when"],
        category: json["category"],
        price: json["price"],
        memo: json["memo"]);
  }
}

class MealRecord {
  final List<MealInfo>? meal;
  final int? day_budget;
  final int? consumption;

  MealRecord({
    required this.meal,
    required this.day_budget,
    required this.consumption,
  });

  factory MealRecord.fromJson(Map<String, dynamic> json) {
    var list = json["records"] as List;
    List<MealInfo> mealInfoList =
        list.map((i) => MealInfo.fromJson(i)).toList();

    return MealRecord(
        meal: mealInfoList,
        day_budget: json["day_budget"],
        consumption: json["comsumption"]);
  }

/*
  dynamic toJson() => {
        "meal": meal,
        "day_budget": day_budget,
        "consumption": consumption,
      };
*/
}
