import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MealProvider with ChangeNotifier {
  Future<MealChart> fetchMealChart() async {
    //print("함수 들어옴");
    final Parameters = {'year': 2023, 'month': 5}.map((key, value) =>
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

/*
//0518수정
class MealTime{
  int? breakfast;
  int? lunch;
  int? dinner;
  int? snack;

  MealTime(
    {required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack});

  factory MealTime.fromJson(Map<String, dynamic> json) {
    return MealTime(
        breakfast: json["아침"],
        lunch: json["점심"],
        dinner: json["저녁"],
        snack: json["간식"]);
  }
}


class MealChart {
  final List<MealTime>? mealtime;
  final int? total_count;

  MealChart(
      {required this.mealtime,
        required this.total_count});

  factory MealChart.fromJson(Map<String, dynamic> json) {
    return MealChart(
        mealtime:json["record_byTime"],
        total_count: json["total_count"]
    );
  }
  /*
  final List<MealTime>? mealtime;
  final int? total_count;

  MealChart(
      {required this.mealtime,
        required this.total_count});

  factory MealChart.fromJson(Map<String, dynamic> json) {
    var list = json["record_byTime"] as List;
    List<MealTime> mealtimeList =
      list.map((i) => MealTime.fromJson(i)).toList();

    return MealChart(
        mealtime: mealtimeList,
        total_count: json["total_count"]);
  }

   */

  // dynamic toJson() => {
  //       "mealtime":mealtime,
  //       "total_count": total_count,
  //};

}
//0518수정
 */

}
void main() {
  print("main 함수 실행");
  MealProvider().fetchMealChart();
}
