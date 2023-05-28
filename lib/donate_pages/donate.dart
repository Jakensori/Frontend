import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_project/donate_pages/api_moneybox.dart';
import 'api_moneybox.dart';
import 'api_campaign.dart';
import 'mydonation.dart';
import 'one_campaign.dart';
import 'savings.dart';
//import 'four_campaign.dart';
//import 'four_api_campaign.dart';

//import 'four_campaign.dart';

class Donating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DonatingPage(title: 'Donating Page'),
    );
  }
}

class DonatingPage extends StatefulWidget {
  final String title;

  DonatingPage({Key? key, required this.title}) : super(key: key);

  @override
  _DonatingPageState createState() => _DonatingPageState();
}

class _DonatingPageState extends State<DonatingPage> {
  late Future<List<CampaignRecord>> _futureCampaign;
  late Future<Map<String, dynamic>> _futureMoneyBox;

  @override
  void initState() {
    super.initState();
    _futureCampaign = fetchCampaign();
    _futureMoneyBox = fetchMoneyBox();
  }

  get width => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        title: Text(
          '',
          style: TextStyle(
            fontSize: 25, // 폰트 크기
            fontWeight: FontWeight.bold, // 폰트 두께
            color: Colors.black, // 폰트 색상
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          child: Stack(
        children: [
          Container(
            width: 600,
            height: 150,
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(70, 50, 10, 5),
            child: Text(
              '나의 기부 저금통',
              style: TextStyle(
                fontSize: 18, // 폰트 크기
                fontWeight: FontWeight.w600, // 폰트 두께
                color: Colors.black, // 폰트 색상
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(220, 85, 10, 5),
              child: FutureBuilder<Map<String, dynamic>>(
                future: _futureMoneyBox,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    final moneyBoxData = snapshot.data;
                    final savings = moneyBoxData?['savings'] ?? 0;

                    return Container(
                      //width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              '$savings 원',
                              style: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.w600, // 폰트 두께
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )),
          Container(
            margin: EdgeInsets.fromLTRB(70, 130, 180, 5),
            child: TextButton(
              child: Text(
                '기부 가능 리스트 보기',
                style: TextStyle(
                  fontSize: 12, // 폰트 크기
                  fontWeight: FontWeight.w600, // 폰트 두께
                  color: Colors.black, // 폰트 색상
                ),
              ),
              onPressed: () {
                // 페이지 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SavingPage(
                            title: '',
                          )),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(210, 130, 50, 5),
            child: TextButton(
              child: Text(
                '나의 기부 목록 보기',
                style: TextStyle(
                  fontSize: 12, // 폰트 크기
                  fontWeight: FontWeight.w600, // 폰트 두께
                  color: Colors.black, // 폰트 색상
                ),
              ),
              onPressed: () {
                // 페이지 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MydonationPage(
                            title: '',
                          )),
                );
              },
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 220, 10, 0),
              child: FutureBuilder<List<CampaignRecord>>(
                  future: _futureCampaign,
                  builder: (context, snapshot) {
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Colors.amber[100],
                                      width: 230,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                //color: Colors.amber[300],

                                                /*borderRadius:
                                                  BorderRadius.circular(10),*/
                                                ),
                                            child: Text(
                                              campaign.title ?? '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                campaign.image ?? '',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              campaign.summary ?? '',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 30),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${campaign.currentAmount ?? 0}원 / ${campaign.goalAmount ?? 0}원',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            campaign.title ??
                                                                ''),
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                                height: 10),
                                                            Image.network(
                                                                campaign.image ??
                                                                    ''),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                                '요약: ${campaign.summary ?? ''}'),
                                                            SizedBox(
                                                                height: 30),
                                                            Text(
                                                                'Start Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(campaign.startYmd.toString()))}'),
                                                            SizedBox(
                                                                height: 10),
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
                                                                      builder:
                                                                          (context) =>
                                                                              OneCampaignPage()));
                                                            },
                                                            child:
                                                                Text('기부하러가기'),
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
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.amber,
                                                  minimumSize: Size(100, 30),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
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
        ],
      )),
    ));
  }
}
