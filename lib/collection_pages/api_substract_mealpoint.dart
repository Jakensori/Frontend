import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int?> sendRequest(int usedPoint) async {
  Map<String, dynamic> requestData = {
    "used_point": usedPoint,
  };
  var token =
      'da7a36994cf38f8394214b7a7803d25ee066274398ae903580e9afe4275d614e';
  final response = await http.post(
    Uri.parse('http://52.78.205.224:8000/donation/redeem/'),
    body: json.encode(requestData),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'token $token',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseBody = json.decode(response.body);
    int mealPointNow = responseBody['mealpoint_now'];
    return mealPointNow;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return null;
  }
}
