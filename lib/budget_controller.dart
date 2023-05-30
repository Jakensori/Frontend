import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class budgetProvider with ChangeNotifier {
  //POST
  Future<void> postBudget(int budget) async {
    print("<<<예산 POST 실행>>>");

    var url = Uri.parse('http://52.78.205.224:8000/custom/');

    var body = json.encode(<String, dynamic>{'month_budget': budget});

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Charset': 'utf-8',
          //'Autorization': 'token $token',
        },
        body: body);

    print("예산 Code: ${response.statusCode}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("<<<예산 POST 성공>>>");
    } else {
      throw Exception('<<<예산 POST 실패>>>');
    }
  }

  //PATCH
  Future<void> patchBudget(int budget) async {
    print("<<<예산 PATCH 실행>>>");

    var url = Uri.parse('http://52.78.205.224:8000/custom/budget/');

    var body = json.encode(<String, dynamic>{'month_budget': budget});

    final response = await http.patch(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Charset': 'utf-8',
          //'Autorization': 'token $token',
        },
        body: body);

    print("예산 Code: ${response.statusCode}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("<<<예산 PATCH 성공>>>");
    } else {
      throw Exception('<<<예산 PATCH 실패>>>');
    }
  }
}
