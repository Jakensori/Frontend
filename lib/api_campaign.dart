import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      await http.get(Uri.parse('http://192.168.187.21:8000/campaign/posts/all'));
  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
    return jsonData
        .map((campaignData) => CampaignRecord.fromJson(campaignData))
        .toList();
  } else {
    throw Exception('Failed to load campaign data');
  }
}

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
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final campaigns = context.watch<List<CampaignRecord>>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Campaign List'),
      ),
      body: ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final campaign = campaigns[index];
          return ListTile(
            title: Text(campaign.title ?? ''),
            subtitle: Text(campaign.summary ?? ''),
            leading: Image.network(campaign.image ?? ''),
            trailing: Text(
                '${campaign.currentAmount ?? 0}원 / ${campaign.goalAmount ?? 0}원'),
          );
        },
      ),
    );
  }
}
//원래 코드가 이건데..