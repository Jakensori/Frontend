import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<MealRecord> fetchInfo() async {
  var url = 'http://127.0.0.1:8000/'; // url 추가
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답했다');
    print(json.decode(response.body));
    return MealRecord.fromJson(json.decode(response.body));
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('계좌정보를 불러오는데 실패했습니다');
  }
}

class MealRecord {
  final String name; // 내용
  final String meal; // 식사
  final String type; // 방식
  final int price; // 금액

  MealRecord(
      {required this.name,
      required this.meal,
      required this.type,
      required this.price});

  factory MealRecord.fromJson(Map<String, dynamic> json) {
    return MealRecord(
        name: json["name"],
        meal: json["meal"],
        type: json["type"],
        price: json["price"]);
  }
}
