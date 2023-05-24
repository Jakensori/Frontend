/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/cupertino.dart';

class NewCharacterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새로운 캐릭터'),
      ),
    ); // MaterialApp
  }
}
*/
/*
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PointBox {
  final int? mealPoint;
  final String? level;

  PointBox({
    required this.mealPoint,
    required this.level,
  });

  factory PointBox.fromJson(Map<String, dynamic> json) {
    return PointBox(
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PointBoxState(),
      child: MaterialApp(
        title: 'My App',
        home: MyHomePage(),
      ),
    );
  }
}

class PointBoxState with ChangeNotifier {
  int? _mealPoint;

  int? get mealPoint => _mealPoint;

  set mealPoint(int? value) {
    _mealPoint = value;
    notifyListeners(); // 상태 변경을 알림
  }

  void deductMealPoint(int amount) {
    if (_mealPoint != null) {
      _mealPoint = _mealPoint! - amount;
      notifyListeners();
    }
  }

  Future<void> fetchAndSetMealPoint() async {
    try {
      final jsonData = await fetchPointBox();
      final PointBox = PointBox.fromJson(jsonData);
      _mealPoint = PointBox.mealPoint;
      notifyListeners();
    } catch (error) {
      print('Error fetching meal point: $error');
    }
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<PointBoxState>(
              builder: (context, moneyBoxState, _) {
                final mealPoint = moneyBoxState.mealPoint;
                return Text('Meal Point: ${mealPoint ?? ''}');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final moneyBoxState =
                    Provider.of<PointBoxState>(context, listen: false);
                moneyBoxState.deductMealPoint(20);
              },
              child: Text('Deduct 20 from Meal Point'),
            ),
          ],
        ),
      ),
    );
  }
}
*/