import 'package:http/http.dart' as http;
import 'dart:convert';
import 'collection.dart';
import 'api_mealpoint.dart';

/*
Future<void> sendRequest() async {
  Map<String, dynamic> requestData = {
    "used_point": 20,
  };*/
Future<void> sendRequest(int usedPoint) async {
  Map<String, dynamic> requestData = {
    "used_point": usedPoint,
  };

  final response = await http.post(
    Uri.parse('http://52.78.205.224:8000/donation/redeem/'),
    body: json.encode(requestData),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);
    bool result = responseData['result'];
    String code = responseData['code'];
    Map<String, dynamic> data = responseData['data'];

    String pointHistoryId = data['pointHistoryId'];
    String orderIdentifier = data['orderIdentifier'];

    int mealPointValue = data['meal_point'];
    int levelValue = data['level'];
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
