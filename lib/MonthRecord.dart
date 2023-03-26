import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MonthRecordProvider with ChangeNotifier {
  MealChart? _monthRecord;
  MealChart? get monthRecord => _monthRecord;

  Future<MealChart> fetchMonthRecord() async {
    print("함수 들어옴");

    final Parameters = {'year': 2023, 'month': 3}.map((key, value) =>
        MapEntry(key, value.toString())); // int 허용 안되서 string으로 바꿔줌.

    var url = Uri.parse('http://192.168.17.46:8000/record/time/2/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final newURI = url.replace(queryParameters: Parameters); // 쿼리 파라미터 보내줌
    final response = await http.get(newURI, headers: headers);
    print('응답했다');

    if (response.statusCode == 200) {
      //만약 서버가 ok응답을 반환하면, json을 파싱합니다
      print('응답했다');
      print(json.decode(utf8.decode(response.bodyBytes))); // 한글 깨짐 해결 !
      _monthRecord = MealChart.fromJson(json.decode(response.body));
      notifyListeners();
      return MealChart.fromJson(json.decode(response.body));
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      throw Exception('계좌정보를 불러오는데 실패했습니다');
    }
  }
}

class MealChart {
  final Map<String, int>? record_byTime;
  final int? total_count;
  /*final String? when;
  final String? category;
  final int? price;
  final String? memo;*/

  MealChart(
      // {required this.when,
      // required this.category,
      // required this.price,
      // required this.memo}
          {required this.record_byTime,
        required this.total_count});

  factory MealChart.fromJson(Map<String, dynamic> json) {
    return MealChart(
      // when: json["when"],
      // category: json["category"],
      // price: json["price"],
      // memo: json["memo"]);
        record_byTime: json['record_byTime'],
        total_count: json['total_count']);
  }


  dynamic toJson() => {
        'record_byTime': record_byTime,
        'total_count': total_count,
      };

}

// 화면에 데이터 보여주는 코드
class MyApp extends StatelessWidget {
  Future<MealChart>? meal;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MonthRecordProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('상태 관리 예제'),
          ),
          body: Center(
            child: Consumer<MonthRecordProvider>(
              builder: (context, provider, child) {
                if (provider.monthRecord == null) {
                  return CircularProgressIndicator();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text('메뉴명: ${provider.mealRecord!.when}'),
                    // Text('식사: ${provider.mealRecord!.category}'),
                    // Text('방식: ${provider.mealRecord!.price}'),
                    // Text('금액: ${provider.mealRecord!.memo}'),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  print("main 함수 실행");
  MonthRecordProvider().fetchMonthRecord();
}
