import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoneyBox {
  final int? mealPoint;
  final String? level;

  MoneyBox({
    required this.mealPoint,
    required this.level,
  });

  factory MoneyBox.fromJson(Map<String, dynamic> json) {
    return MoneyBox(
      mealPoint: json['meal_point'] as int?,
      level: json['level'] as String?,
    );
  }
}

Future<Map<String, dynamic>> fetchMoneyBox() async {
  final response = await http
      .get(Uri.parse('http://52.78.205.224:8000/custom/mealpoint/1/'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    return jsonData as Map<String, dynamic>;
  } else {
    throw Exception('Failed to load moneybox data');
  }
}

class MoneyBoxWidget extends StatelessWidget {
  final MoneyBox moneybox;

  MoneyBoxWidget(this.moneybox);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10, // 이미지 사이즈 조정
      height: 10,
    );
  }
}

class MyApp extends StatelessWidget {
  Future<Map<String, dynamic>> fetchAndStyleCampaign() async {
    final Map<String, dynamic> moneyboxData = await fetchMoneyBox();
    return moneyboxData;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Campaigns'),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: fetchAndStyleCampaign(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> moneyboxData = snapshot.data!;
              MoneyBox moneybox = MoneyBox.fromJson(moneyboxData);
              return MoneyBoxWidget(moneybox);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
