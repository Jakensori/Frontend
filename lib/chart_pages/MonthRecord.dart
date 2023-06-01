import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MonthRecordProvider with ChangeNotifier {
  MonthRecord? _monthChart;
  MonthRecord? get monthRecord => _monthChart;

  Future<MonthRecord> fetchMonthRecord(int Year, int Month) async {
    print("함수 들어옴");
    final Parameters = {'year': Year, 'month': Month}.map((key, value) =>
       MapEntry(key, value.toString())); // int 허용 안되서 string으로 바꿔줌.


    var url = Uri.parse('http://52.78.205.224:8000/record/accountbook/1/');
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
      _monthChart = MonthRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      notifyListeners();
      return MonthRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      throw Exception('계좌정보를 불러오는데 실패했습니다');
    }

  }
}

class DailyRecord {
  String today_date='';
  int donation=0;
  int differ=0;
  DailyRecord({ required this.today_date,required this.donation, required this.differ});

  factory DailyRecord.fromJson(Map<String,dynamic> json){
    return DailyRecord(
      today_date: json["today_date"]??'',
      donation: json["donation"]??0,
      differ : json["differ"]??0,
    );
  }
}

class MonthRecord {
  final List<DailyRecord>? daily_record;
  int month_consume=0;
  int month_donation=0;
  int month_budget=0;
  int month_saving=0;

  MonthRecord({
    required this.daily_record,
    required this.month_consume,
    required this.month_donation,
    required this.month_budget,
    required this.month_saving,
  });

  factory MonthRecord.fromJson(Map<String, dynamic> json) {
    var list = json["하루 기록들"] as List;
    List<DailyRecord> daily_record_list = list.map((i)=> DailyRecord.fromJson(i)).toList();

    return MonthRecord(
        daily_record: daily_record_list,
        month_consume: json["총 소비금"]??0,
        month_donation: json["총 기부금"]??0,
        month_budget: json["한 달 예산"]??0,
        month_saving:json["남은 금액"]??0,
    );
  }

}