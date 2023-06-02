import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toss_payment/toss_payment.dart';

import '../toss/tosspayment.dart';

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
      await http.get(Uri.parse('http://52.78.205.224:8000/chat/posts/all/'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
    return jsonData
        .map((campaignData) => CampaignRecord.fromJson(campaignData))
        .toList();
  } else {
    throw Exception('Failed to load campaign data');
  }
}

class CampaignRecordWidget extends StatelessWidget {
  final CampaignRecord campaign;

  CampaignRecordWidget(this.campaign);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10, // 이미지 사이즈 조정
      height: 10,
      child: Image.network(
        campaign.image ?? '',
        fit: BoxFit.cover,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  Future<List<CampaignRecord>> fetchAndStyleCampaign() async {
    final List<CampaignRecord> campaigns = await fetchCampaign();
    return campaigns;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Consumer<List<CampaignRecord>>(
        builder: (context, campaigns, _) {
          if (campaigns != null) {
            return ListView.builder(
              itemCount: campaigns.length,
              itemBuilder: (context, index) {
                CampaignRecord campaign = campaigns[index];
                return ListTile(
                  title: Text(
                    campaign.title ?? '',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TossPaymentPage(
                          foundation: campaign.title ?? '',
                          money: 15000,
                        ), // 여기서 값을 전달
                      ),
                    );
                  },
                  // ...
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
