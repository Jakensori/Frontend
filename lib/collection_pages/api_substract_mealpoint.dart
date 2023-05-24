import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendRequest() async {
  // 요청 데이터 생성
  Map<String, dynamic> requestData = {
    "used_point": 20,
  };

  // 요청 보내기
  final response = await http.post(
    Uri.parse('http://52.78.205.224:8000/donation/redeem/'), // 요청 URL
    body: json.encode(requestData), // 요청 데이터를 JSON 문자열로 인코딩
    headers: {'Content-Type': 'application/json'}, // 헤더에 Content-Type 설정
  );

  // 응답 처리
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);
    bool result = responseData['result'];
    String code = responseData['code'];
    Map<String, dynamic> data = responseData['data'];

    // 필요한 데이터 추출
    String pointHistoryId = data['pointHistoryId'];
    String orderIdentifier = data['orderIdentifier'];
    // ...

    // 필요한 작업 수행
    // ...

  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
