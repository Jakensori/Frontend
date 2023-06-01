import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ExpenseProvider with ChangeNotifier {
  Future<ExpenseChart> fetchExpenseChart(int year,int month) async {
    //print("함수 들어옴");
    final Parameters = {'year': year, 'month': month}.map((key, value) =>
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
  int homemade;
  int eating_out;
  int delivery;
  int cafe;
  int etc;
  int total_count;

  int amt_homemade;
  int amt_eating_out;
  int amt_delivery;
  int amt_cafe;
  int amt_etc;


  ExpenseChart({required this.homemade,
    required this.eating_out,
    required this.delivery,
    required this.cafe,
    required this.etc,
    required this.total_count,
    required this.amt_homemade,
    required this.amt_eating_out,
    required this.amt_delivery,
    required this.amt_cafe,
    required this.amt_etc
  });

  factory ExpenseChart.fromJson(Map<String, dynamic> json) {
    final recordByCategory = json["record_byCategory"] as Map<String, dynamic>?;

      return ExpenseChart(
        homemade: recordByCategory?["집밥"]?[0] as int? ?? 0,
        eating_out: recordByCategory?["외식"]?[0] as int? ?? 0,
        delivery: recordByCategory?["배달"]?[0] as int? ?? 0,
        cafe: recordByCategory?["카페"]?[0] as int? ?? 0,
        etc: recordByCategory?["기타"]?[0] as int? ?? 0,
        total_count: json["total_count"] as int? ?? 0,
        amt_homemade: recordByCategory?["집밥"]?[1] as int? ?? 0,
        amt_eating_out: recordByCategory?["외식"]?[1] as int? ?? 0,
        amt_delivery: recordByCategory?["배달"]?[1] as int? ?? 0,
        amt_cafe: recordByCategory?["카페"]?[1] as int? ?? 0,
        amt_etc: recordByCategory?["기타"]?[1] as int? ?? 0,
      );

  }
}
