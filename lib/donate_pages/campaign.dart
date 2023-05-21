/*import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Campaign>> fetchCampaign() async {
  final url = 'http://<백엔드 API 주소>/updateCampaign/';
  final response = await http.post(Uri.parse(url));

  if (response.statusCode == 200) {
    print('응답했다');
    List<dynamic> jsonData = json.decode(response.body);
    List<Campaign> campaigns =
        jsonData.map((json) => Campaign.fromJson(json)).toList();
    return campaigns;
  } else {
    throw Exception('Failed to fetch campaign data');
  }
}

class Campaign {
  final String rdonaBoxNo;
  final String title;
  final String image;
  final String summary;
  final String hlogName;
  final DateTime startYmd;
  final DateTime endYmd;
  final int currentAmount;
  final int donationCount;
  final int goalAmount;

  Campaign({
    required this.rdonaBoxNo,
    required this.title,
    required this.image,
    required this.summary,
    required this.hlogName,
    required this.startYmd,
    required this.endYmd,
    required this.currentAmount,
    required this.donationCount,
    required this.goalAmount,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      rdonaBoxNo: json['rdonaBoxNo'],
      title: json['title'],
      image: json['image'],
      summary: json['summary'],
      hlogName: json['hlogName'],
      startYmd: DateTime.parse(json['startYmd']),
      endYmd: DateTime.parse(json['endYmd']),
      currentAmount: json['currentAmount'],
      donationCount: json['donationCount'],
      goalAmount: json['goalAmount'],
    );
  }
}
*/