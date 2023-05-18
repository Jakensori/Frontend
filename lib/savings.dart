import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api_campaign.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'one_campaign.dart';

class Saving extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class SavingPage extends StatefulWidget {
  SavingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SavingPageState createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  late Future<List<CampaignRecord>> _futureCampaign;

  @override
  void initState() {
    super.initState();
    _futureCampaign = fetchCampaign();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: FutureBuilder<List<CampaignRecord>>(
                future: _futureCampaign,
                builder: (context,
                        snapshot) /* {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final campaign = snapshot.data![index];
                        return ListTile(
                          title: Container(
                            width: 300, // 
                            child: Text(
                              campaign.title ?? '',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          subtitle: Container(
                            width: 200, // 
                            child: Text(campaign.summary ?? ''),
                          ),
                          leading: Container(
                            width: 100, // 
                            child: Image.network(campaign.image ?? ''),
                          ),
                          trailing: Container(
                            width: 50, // 
                            child: Text(
                              '${campaign.currentAmount ?? 0}원 / ${campaign.goalAmount ?? 0}원',
                            ),
                          ),
                        );
                      },
                    );*/
                    {
                  if (snapshot.hasData) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (final campaign in snapshot.data!)
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(campaign.title ?? ''),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Image.network(campaign.image ?? ''),
                                        SizedBox(height: 10),
                                        Text('요약: ${campaign.summary ?? ''}'),
                                        SizedBox(height: 30),
                                        Text(
                                            'Start Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(campaign.startYmd.toString()))}'),
                                        SizedBox(height: 10),
                                        Text(
                                            'End Date: ${DateFormat('yyyy-MM-dd ').format(DateTime.parse(campaign.endYmd.toString()))}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OneCampaignPage()));
                                        },
                                        child: Text('기부하러가기'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          campaign.title ?? '',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 50),
                                      Container(
                                        width: double.infinity,
                                        child: Image.network(
                                          campaign.image ?? '',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                      SizedBox(height: 50),
                                      Text(
                                        campaign.summary ?? '',
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '${campaign.currentAmount ?? 0}원 / ${campaign.goalAmount ?? 0}원',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20), // 각 항목 사이의 가로 간격
                              ],
                            ),
                          ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }))
        /*
      ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 180, 5),
            child: Text(
              '기부 목록',
              style: TextStyle(
                fontSize: 24, // 폰트 크기
                fontWeight: FontWeight.w700, // 폰트 두께
                color: Colors.black, // 폰트 색상
              ),
            ),
          ),
          /*Container(
            child: Text(" 300000원"),
          ),*/

          /* Container(
              margin: EdgeInsets.fromLTRB(5, 50, 180, 5),
              child: (SingleChildScrollView(
                  child: Column(children: [
                Square(),
                Square2(),
                Square(),
                Square2(),
                Square(),
                Square2(),
                Square(),
                Square2(),
                Square(),
                Square2(),
                Square(),
              ]))))*/
        ],
      ),*/
        );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
