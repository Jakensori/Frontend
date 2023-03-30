import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api_campaign.dart';
import 'dart:async';

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
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final campaign = snapshot.data![index];
                        return ListTile(
                          title: Text(campaign.title ?? ''),
                          subtitle: Text(campaign.summary ?? ''),
                          leading: Image.network(campaign.image ?? ''),
                          trailing: Text(
                              '${campaign.currentAmount ?? 0}원 / ${campaign.goalAmount ?? 0}원'),
                        );
                      },
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
