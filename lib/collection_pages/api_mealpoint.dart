import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*
class MoneyBox {
  final String? mealPoint;
  final String? level;

  MoneyBox({
    required this.mealPoint,
    required this.level,
  });

  factory MoneyBox.fromJson(Map<String, dynamic> json) {
    return MoneyBox(
      mealPoint: json['meal_point'] as String?,
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
*/
class MealPoint {
  int? meal_point;
  int? level;

  MealPoint({
    required this.meal_point,
    required this.level,
  });

  factory MealPoint.fromJson(Map<String, dynamic> json) {
    return MealPoint(
      meal_point: json["meal_point"],
      level: json["level"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meal_point'] = this.meal_point;
    data['level'] = this.level;

    return data;
  }
}

Future<MealPoint> getInfo() async {
  print("<<<GET 실행>>>");

  //String? token = await UserProvider().storage.read(key: 'token');
  //print(token);

  var url = Uri.parse('http://52.78.205.224:8000/custom/mealpoint/1/');

  Map<String, String>? headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    //'Autorization': 'token $token'
    //"token":"18a314e1cd9b753888a44a2fc05942995bc7d6c470004fc4b86dd08fab04821c",
  };

  //var newURI = url.replace(queryParameters: Parameters);
  // print(newURI);
  var response = await http.get(url, headers: headers);

  print('기록 response Code : ${response.statusCode}');

  if (response.statusCode == 200) {
    print('기록 GET 성공');
    print(response.body);
    //notifyListeners();
    return MealPoint.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('기록 GET 실패');
  }
}
