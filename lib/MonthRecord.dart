import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MonthRecordProvider with ChangeNotifier {
  MonthRecord? _monthChart;

  MonthRecord? get monthRecord => _monthChart;

  Future<MonthRecord> fetchMonthRecord() async {
    print("함수 들어옴");
    //final Parameters = {'year': 2023, 'month': 3}.map((key, value) =>
    //    MapEntry(key, value.toString())); // int 허용 안되서 string으로 바꿔줌.

    var url = Uri.parse('http://192.168.187.25:8000/record/2/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    //final newURI = url.replace(queryParameters: Parameters); // 쿼리 파라미터 보내줌
    final response = await http.get(url, headers: headers);
    print('응답했다');

    if (response.statusCode == 200) {
      //만약 서버가 ok응답을 반환하면, json을 파싱합니다
      print('응답했다');
      print(json.decode(utf8.decode(response.bodyBytes))); // 한글 깨짐 해결 !
      _monthChart = MonthRecord.fromJson(json.decode(response.body));
      notifyListeners();
      return MonthRecord.fromJson(json.decode(response.body));
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

  factory DailyRecord.fromJson(Map<String,dynamic> parsedJson){
    return DailyRecord(
      today_date: parsedJson['today_date'],
      donation: parsedJson['donation'],
      differ : parsedJson['differ'],
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

  factory MonthRecord.fromJson(Map<String, dynamic> parsedjson) {
    var list = parsedjson['daily_record'] as List;
    List<DailyRecord> daily_record_list = list.map((i)=> DailyRecord.fromJson(i)).toList();

    return MonthRecord(
        daily_record: daily_record_list,
        total_consume: parsedjson['total_consume'],
        total_donate: parsedjson['total donate'],
        month_budget: parsedjson['month_budget'],
        month_saving:parsedjson['month_saving']);
  }

/*
  dynamic toJson() => {
        'record_byTime': record_byTime,
        'total_count': total_count,
      };
   */
}

void main() {
  print("main 함수 실행");
  MonthRecordProvider().fetchMonthRecord();
}