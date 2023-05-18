import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_project/savings.dart';
import 'four_campaign.dart';
import 'four_api_campaign.dart';
import 'one_campaign.dart';
//import 'four_campaign.dart';

class Donate extends StatelessWidget {
  Donate({Key? key}) : super(key: key);

  get width => null;

  late Future<List<CampaignRecord>> _futureCampaign;

  @override
  void initState() {
    initState();
    _futureCampaign = fetchCampaign();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        title: Text(
          '기부하기',
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
            height: 200,
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(70, 80, 180, 5),
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
            margin: EdgeInsets.fromLTRB(70, 200, 180, 5),
            child: TextButton(
              child: Text(
                '기부 리스트 보기',
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
                  MaterialPageRoute(builder: (context) => Donate()),
                );
              },
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(70, 400, 180, 5),
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
        ],
      )),
    ));
  }
}
