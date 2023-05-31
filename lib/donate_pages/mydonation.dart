import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:intl/intl.dart';

import 'api_mydonation.dart';
import 'one_campaign.dart';

class Mydonation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class MydonationPage extends StatefulWidget {
  MydonationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SavingPageState createState() => _SavingPageState();
}

class _SavingPageState extends State<MydonationPage> {
  late Future<List<MyCampaignRecord>> _futureCampaign;

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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
              width: double.infinity,
              child: FutureBuilder<List<MyCampaignRecord>>(
                  future: _futureCampaign,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        scrollDirection: Axis.vertical,
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
                                    width: 330,
                                    margin: EdgeInsets.symmetric(vertical: 30),
                                    decoration: BoxDecoration(
                                      color: Colors.amber[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 15),
                                            Container(
                                              width: 260,
                                              color: Colors.white,
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                campaign.title ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: 260,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  campaign.image ?? '',
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: 260,
                                              padding: EdgeInsets.all(10),
                                              color: Colors.amber[100],
                                              child: Text(
                                                campaign.summary ?? '',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: 260,
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                '${campaign.currentAmount ?? 0}원 / ${campaign.goalAmount ?? 0}원',
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: 260,
                                              child: Text(
                                                '❤${campaign.mydonation_amount ?? 0}원 기부했어요❤ ',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  //SizedBox(width: 50), // 각 항목 사이의 가로 간격
                                ],
                              ),
                            ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  })),
        ));
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
