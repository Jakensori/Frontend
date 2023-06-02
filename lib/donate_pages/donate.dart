import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:temp_project/donate_pages/api_moneybox.dart';
import '../toss/tosspayment.dart';
import 'api_campaign.dart';
import 'mydonation.dart';
import 'one_campaign.dart';
import 'savings.dart';
import 'package:temp_project/const/colors.dart';
import 'package:flutter/cupertino.dart';

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
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: WHITE_COLOR,
            actions:[
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: IconButton(
                  icon: Icon(CupertinoIcons.mail, color: BLACK_COLOR),
                  iconSize: 35.0,
                  onPressed: () {
                  },
                ),
              ),
            ],
          ),
      body: Container(
          child: Stack(
        children: [
          Container(
            width: 600,
            height: 150,
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            decoration: BoxDecoration(
              color: Color(0xffFFC646),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(80, 50, 10, 5),
            child: Text(
              '나의 기부 저금통',
              style: TextStyle(
                fontSize: 15, // 폰트 크기
                fontWeight: FontWeight.w600, // 폰트 두께
                color: Color(0xff444444), // 폰트 색상
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(80, 70, 10, 5),
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
                                fontSize: 25,
                                fontWeight: FontWeight.w600, // 폰트 두께
                                color: Color(0xff444444),
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
            margin: EdgeInsets.fromLTRB(80, 130, 10, 5),
            width: 100,
            height: 30,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow.shade100),
              ),
              child: Text(
                '기부 가능 리스트',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff444444),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavingPage(
                      title: '',
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(215, 130, 10, 5),
            width: 100,
            height: 30,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.amber.shade100),
              ),
              child: Text(
                '나의 기부 리스트',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff444444),
                ),
              ),
              onPressed: () {
                // 페이지 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MydonationPage(
                      title: '',
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 220, 20, 5),
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
                                                                child: TossPaymentPage(
                                                                    foundation:
                                                                        campaign.hlogName ??
                                                                            '',
                                                                    money: 123),
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Colors.amber[100],
                                      width: 230,
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                          SizedBox(height: 5),
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
                                          SizedBox(height: 5),
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
                                          SizedBox(width: 10),
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
                                                        contentPadding:
                                                            EdgeInsets.all(
                                                                0), // 패딩을 제거하여 컨텐츠에 꽉 차도록 설정
                                                        content:
                                                            SingleChildScrollView(
                                                          // 스크롤 가능하도록 컨텐츠를 감싸기
                                                          child: Column(
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
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        '결제하기'),
                                                                    content: Text(
                                                                        '어떤 방식으로 결제를 진행하시겠습니까'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => OneCampaignPage(),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: Text(
                                                                            '포인트로 기부'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                            builder:
                                                                                (context) {
                                                                              return Provider<CampaignRecord>.value(
                                                                                value: campaign,
                                                                                child: Align(
                                                                                  child: Text(
                                                                                    campaign.hlogName ?? '',
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ));
                                                                        },
                                                                        child: Text(
                                                                            '바로 기부하기'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child:
                                                                Text('기부창 열기'),
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
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff444444),
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xffFFC646),
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
