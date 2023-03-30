import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class SettlementProvider with ChangeNotifier {
  SettlementInfo? _settleInfo;
  SettlementInfo? get mealRecord => _settleInfo;

  //GET 함수
  Future<SettlementInfo> getSettlement() async {
    print("함수 들어옴");

    var url = Uri.parse(
        'http://192.168.187.25:8000/record/settlement/<int:user_id>/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.get(url, headers: headers);
    print('GET 응답');

    if (response.statusCode == 200) {
      //만약 서버가 ok응답을 반환하면, json을 파싱합니다
      print('응답했다');
      print(json.decode(utf8.decode(response.bodyBytes))); // 한글 깨짐 해결 !
      _settleInfo =
          SettlementInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      notifyListeners();
      return SettlementInfo.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      throw Exception('계좌정보를 불러오는데 실패했습니다');
    }
  }
}

class SettlementInfo {
  final int? count;
  final int? donation_possible;

  SettlementInfo({
    required this.count,
    required this.donation_possible,
  });

  factory SettlementInfo.fromJson(Map<String, dynamic> json) {
    return SettlementInfo(
      count: json["count"],
      donation_possible: json["donation_possible"],
    );
  }
}
