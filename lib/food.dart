import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MealProvider with ChangeNotifier {
  MealRecord? _mealRecord;
  MealRecord? get mealRecord => _mealRecord;

  Future<MealRecord> fetchMealRecord() async {
    print("함수 들어옴");

    var url = Uri.parse('http://192.168.187.25:8000/record/2/');
    Map<String, String>? headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.get(url, headers: headers);
    print('응답했다');

    if (response.statusCode == 200) {
      //만약 서버가 ok응답을 반환하면, json을 파싱합니다
      print('응답했다');
      print(json.decode(utf8.decode(response.bodyBytes))); // 한글 깨짐 해결 !
      _mealRecord = MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      notifyListeners();
      return MealRecord.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      throw Exception('계좌정보를 불러오는데 실패했습니다');
    }
  }
}

class MealInfo {
  final String? when;
  final String? category;
  final int? price;
  final String? memo;

  MealInfo(
      {required this.when,
        required this.category,
        required this.price,
        required this.memo});

  factory MealInfo.fromJson(Map<String, dynamic> json) {
    return MealInfo(
        when: json["when"],
        category: json["category"],
        price: json["price"],
        memo: json["memo"]);
  }
}

class MealRecord {
  final List<MealInfo>? meal;
  final int? day_budget;
  final int? consumption;

  MealRecord({
    required this.meal,
    required this.day_budget,
    required this.consumption,
  });

  factory MealRecord.fromJson(Map<String, dynamic> json) {
    var list = json["records"] as List;
    List<MealInfo> mealInfoList =
    list.map((i) => MealInfo.fromJson(i)).toList();

    return MealRecord(
        meal: mealInfoList,
        day_budget: json["day_budget"],
        consumption: json["comsumption"]);
  }

  dynamic toJson() => {
    "meal": meal,
    "day_budget": day_budget,
    "consumption": consumption,
  };
}

// // 화면에 데이터 보여주는 코드
// class MyApp extends StatelessWidget {
//   Future<MealRecord>? meal;
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => MealProvider(),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text('상태 관리 예제'),
//           ),
//           body: Center(
//             child: Consumer<MealProvider>(
//               builder: (context, provider, child) {
//                 if (provider.mealRecord == null) {
//                   return CircularProgressIndicator();
//                 }
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Text('메뉴명: ${provider.mealRecord!.when}'),
//                     // Text('식사: ${provider.mealRecord!.category}'),
//                     // Text('방식: ${provider.mealRecord!.price}'),
//                     // Text('금액: ${provider.mealRecord!.memo}'),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   print("main 함수 실행");
//   MealProvider().fetchMealRecord();
// }
