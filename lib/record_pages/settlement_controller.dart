import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:temp_project/record_pages/settlement.dart';

class SettlementProvider with ChangeNotifier {
  // SettlementInfo? _settleInfo;
  // SettlementInfo? get mealRecord => _settleInfo;

  //GET 함수
  Future<SettlementInfo> getSettlement(int year, int month, int day) async {
    final Parameters = {'year': year, 'month': month, 'day': day}
        .map((key, value) => MapEntry(key, value.toString()));

    var url = Uri.parse('http://52.78.205.224:8000/record/settlement/1/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var newURI = url.replace(queryParameters: Parameters);
    var response = await http.get(newURI, headers: headers);

    if (response.statusCode == 200) {
      notifyListeners();
      return SettlementInfo.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('정산 GET 실패');
    }
  }

  Future<void> postSettlement(int today_donation) async {
    print("<<<정산 POST 실행>>>");

    var url = Uri.parse('http://52.78.205.224:8000/record/settlement/1/');
    var body = json.encode(<String, dynamic>{'today_donation': today_donation});

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Charset': 'utf-8',
          //'Autorization': 'token $token',
        },
        body: body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("<<<정산 POST 성공>>>");
    } else {
      throw Exception('정산 POST 실패');
    }
  }
}
