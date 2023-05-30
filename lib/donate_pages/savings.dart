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
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 15),
                                            Container(
                                              width: 230,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Image.network(
                                                  campaign.image ?? '',
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: 230,
                                              child: Text(
                                                campaign.summary ?? '',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: 230,
                                              child: Text(
                                                '${campaign.currentAmount ?? 0}원 / ${campaign.goalAmount ?? 0}원',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                          ],
                                        ),
                                        Container(
                                          width: 230,
                                          child: Text(
                                            campaign.title ?? '',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
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

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
