import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../toss/tosspayment.dart';
import 'api_campaign.dart';
import 'package:toss_payment/toss_payment.dart';
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
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
              width: double.infinity,
              child: FutureBuilder<List<CampaignRecord>>(
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
                                      content: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Image.network(campaign.image ?? ''),
                                            SizedBox(height: 10),
                                            Text(
                                                '요약: ${campaign.summary ?? ''}'),
                                            SizedBox(height: 30),
                                            Text(
                                                'Start Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(campaign.startYmd.toString()))}'),
                                            SizedBox(height: 10),
                                            Text(
                                                'End Date: ${DateFormat('yyyy-MM-dd ').format(DateTime.parse(campaign.endYmd.toString()))}'),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('결제하기'),
                                                  content: Text(
                                                      '어떤 방식으로 결제를 진행하시겠습니까'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                OneCampaignPage(),
                                                          ),
                                                        );
                                                      },
                                                      child: Text('포인트로 기부'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return Provider<
                                                                  CampaignRecord>.value(
                                                                value: campaign,
                                                                child:
                                                                    TossPaymentPage(
                                                                  foundation:
                                                                      campaign.hlogName ??
                                                                          '',
                                                                  money: 15000,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Text('바로 기부하기'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text('기부창 열기'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 30),
                                    width: 330,
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
                                            Container(
                                              width: 260,
                                              color: Colors.white,
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                campaign.title ?? '',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: 260,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    campaign.image ?? '',
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10), // 여백 추가
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
                                            SizedBox(height: 5), // 여백 추가
                                            Container(
                                              width: 260,
                                              padding: EdgeInsets.all(10),
                                              color: Colors.amber[100],
                                              child: Text(
                                                '${campaign.currentAmount ?? 0}원 / ${campaign.goalAmount ?? 0}원',
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Container(
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: FractionalTranslation(
                                                    translation:
                                                        Offset(-0.45, -0.3),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(campaign
                                                                      .title ??
                                                                  ''),
                                                              content: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Image.network(
                                                                      campaign.image ??
                                                                          ''),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                      '요약: ${campaign.summary ?? ''}'),
                                                                  SizedBox(
                                                                      height:
                                                                          30),
                                                                  Text(
                                                                      'Start Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(campaign.startYmd.toString()))}'),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                      'End Date: ${DateFormat('yyyy-MM-dd ').format(DateTime.parse(campaign.endYmd.toString()))}'),
                                                                ],
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                OneCampaignPage()));
                                                                  },
                                                                  child: Text(
                                                                      '기부하러가기'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        '기부하기',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff444444),
                                                        ),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color(0xffFFC646),
                                                        minimumSize:
                                                            Size(100, 30),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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

  // @override
  // State<StatefulWidget> createState() {
  //   throw UnimplementedError();
  // }
}
