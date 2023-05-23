import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MonthRecordProvider with ChangeNotifier {
  MonthRecord? _monthChart;
  MonthRecord? get monthRecord => _monthChart;

  Future<MonthRecord> fetchMonthRecord(int currentYear, int currentMonth) async {
    print("함수 들어옴");
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    final Parameters = {'year': currentYear, 'month': currentMonth}.map((key, value) =>
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
  final String? today_date;
  final int? donation;
  final int? differ;
  DailyRecord({ required this.today_date,required this.donation, required this.differ});

  factory DailyRecord.fromJson(Map<String,dynamic> json){
    return DailyRecord(
      today_date: json["today_date"],
      donation: json["donation"],
      differ : json["differ"],
    );
  }
}

class MonthRecord {
  final List<DailyRecord>? daily_record;
  final int? total_consume;
  final int? total_donate;
  final int? month_budget;
  final int? month_saving;

  MonthRecord({
    required this.daily_record,
    required this.total_consume,
    required this.total_donate,
    required this.month_budget,
    required this.month_saving,
  });

  factory MonthRecord.fromJson(Map<String, dynamic> json) {
    var list = json["하루 기록들"] as List;
    List<DailyRecord> daily_record_list = list.map((i)=> DailyRecord.fromJson(i)).toList();

    return MonthRecord(
        daily_record: daily_record_list,
        total_consume: json["총 소비금"],
        total_donate: json["총 기부금"],
        month_budget: json["한 달 예산"],
        month_saving:json["남은 금액"]);
  }

}