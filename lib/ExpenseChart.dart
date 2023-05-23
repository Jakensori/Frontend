import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class ExpenseProvider with ChangeNotifier {
  Future<ExpenseChart> fetchExpenseChart() async {
    //print("함수 들어옴");
    final Parameters = {'year': 2023, 'month': 5}.map((key, value) =>
        MapEntry(key, value.toString())); // int 허용 안되서 string으로 바꿔줌.

    var url = Uri.parse('http://52.78.205.224:8000/record/category/1/');
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
      return ExpenseChart.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      throw Exception('계좌정보를 불러오는데 실패했습니다');
    }
  }
}

class ExpenseChart {
  final int? homemade;
  final int? eating_out;
  final int? delivery;
  final int? cafe;
  final int? etc;
  final int? total_count;

  ExpenseChart({required this.homemade,
    required this.eating_out,
    required this.delivery,
    required this.cafe,
    required this.etc,
    required this.total_count});

  factory ExpenseChart.fromJson(Map<String, dynamic> json) {
    return ExpenseChart(
        homemade: json["record_byCategory"]["집밥"],
        eating_out: json["record_byCategory"]["외식"],
        delivery: json["record_byCategory"]["배달"],
        cafe: json["record_byCategory"]["카페"],
        etc: json["record_byCategory"]["기타"],
        total_count: json["total_count"]
    );
  }
}
void main() {
  print("main 함수 실행");
  ExpenseProvider().fetchExpenseChart();
}