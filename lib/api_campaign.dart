import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CampaignRecord {
  final String? rdonaBoxNo;
  final String? title;
  final String? image;
  final String? summary;
  final String? hlogName;
  final DateTime? startYmd;
  final DateTime? endYmd;
  final int? currentAmount;
  final int? donationCount;
  final int? goalAmount;

  CampaignRecord({
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

  factory CampaignRecord.fromJson(Map<String, dynamic> json) {
    return CampaignRecord(
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

Future<List<CampaignRecord>> fetchCampaign() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/campaigns/'));
  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
    return jsonData
        .map((campaignData) => CampaignRecord.fromJson(campaignData))
        .toList();
  } else {
    throw Exception('Failed to load campaign data');
  }
}