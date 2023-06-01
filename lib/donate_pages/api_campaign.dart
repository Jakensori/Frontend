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
                            title: campaign.title ?? ''), // 여기서 값을 전달할 예정
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


/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MultiProvider(
        providers: [
          FutureProvider<List<CampaignRecord>>(
            create: (_) => fetchCampaign(),
            initialData: [],
          ),
        ],
        //child: CampaignPage(),
      ),
    );
  }
}

class CampaignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final campaigns = context.watch<List<CampaignRecord>>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Campaign List'),
      ),
      body: ListView.builder(
        //scrollDirection: Axis.horizontal,
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final campaign = campaigns[index];
          return Container(
            //width: 500, // 각 항목의 너비 조정
            child: Card(
              child: Column(
                children: [
                  Image.network(
                    campaign.image ?? '',
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                  ListTile(
                    title: Container(
                      width: 200, // 제목의 폭 조정
                      child: Text(campaign.title ?? ''),
                    ),
                    subtitle: Container(
                      width: 200, // 부제목의 폭 조정
                      child: Text(campaign.summary ?? ''),
                    ),
                    trailing: Container(
                      width: 100, // 우측에 위치한 텍스트의 폭 조정
                      child: Text(
                          '${campaign.currentAmount ?? 0}원 / ${campaign.goalAmount ?? 0}원',
                          style: TextStyle(fontSize: 10)),
                    ),
                  ),
                ], //
              ),
            ),
          );
        },
      ),
    );
  }
}*/