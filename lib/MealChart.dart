import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MealProvider with ChangeNotifier {
  Future<MealChart> fetchMealChart(int currentYear,int currentMonth) async {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    final Parameters = {'year': currentYear, 'month': currentMonth}.map((key, value) =>
        MapEntry(key, value.toString())); // int 허용 안되서 string으로 바꿔줌.

    var url = Uri.parse('http://52.78.205.224:8000/record/time/1/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final newURI = url.replace(queryParameters: Parameters); // 쿼리 파라미터 보내줌
    final response = await http.get(newURI, headers: headers);
    print('GET 응답했다');

    if (response.statusCode == 200) {
      //만약 서버가 ok응답을 반환하면, json을 파싱합니다
      print('GET 응답');

      print(json.decode(utf8.decode(response.bodyBytes))); // 한글 깨짐 해결 !
      notifyListeners();
      return MealChart.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      throw Exception('계좌정보를 불러오는데 실패했습니다');
    }
  }
}

class MealChart {
  final int? breakfast;
  final int? lunch;
  final int? dinner;
  final int? snack;
  final int? total_count;

  MealChart({required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
    required this.total_count});

  factory MealChart.fromJson(Map<String, dynamic> json) {
    return MealChart(
        breakfast: json["record_byTime"]["아침"],
        lunch: json["record_byTime"]["점심"],
        dinner: json["record_byTime"]["저녁"],
        snack: json["record_byTime"]["간식"],
        total_count: json["total_count"]
    );
  }
}