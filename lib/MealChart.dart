import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MealProvider with ChangeNotifier {
  MealChart? _mealChart;
  MealChart? get mealRecord => _mealChart;

  Future<MealChart> fetchMealChart() async {
    print("함수 들어옴");
    final Parameters = {'year': 2023, 'month': 3}.map((key, value) =>
        MapEntry(key, value.toString())); // int 허용 안되서 string으로 바꿔줌.

    var url = Uri.parse('http://172.30.1.47:8000/record/time/2/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final newURI = url.replace(queryParameters: Parameters); // 쿼리 파라미터 보내줌
    final response = await http.get(newURI, headers: headers);
    print('응답했다');

    if (response.statusCode == 200) {
      //만약 서버가 ok응답을 반환하면, json을 파싱합니다
      print('응답했다');
      print(json.decode(utf8.decode(response.bodyBytes))); // 한글 깨짐 해결 !
      _mealChart = MealChart.fromJson(json.decode(response.body));
      notifyListeners();
      return MealChart.fromJson(json.decode(response.body));
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      throw Exception('계좌정보를 불러오는데 실패했습니다');
    }
  }
}

class MealChart {
  final Map<String, int>? record_byTime;
  final int? total_count;

  MealChart(
      {required this.record_byTime,
        required this.total_count});

  factory MealChart.fromJson(Map<String, dynamic> json) {
    return MealChart(
        record_byTime: json['record_byTime'],
        total_count: json['total_count']);
  }


  dynamic toJson() => {
        'record_byTime':record_byTime,
        'total_count': total_count,
  };

}


void main() {
  print("main 함수 실행");
  MealProvider().fetchMealChart();
}
