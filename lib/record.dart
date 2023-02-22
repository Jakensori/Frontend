//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _Record();
}

class _Record extends State<Record> {
  List<String> breakfast = ['삼각김밥'];
  List<String> launch = [];
  List<String> dinner = [];
  List<String> snack = [];
  List<String> others = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFC646),
          title: Text(
            '2023년 2월 1일 (수)',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Color(0xff444444),
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        backgroundColor: Color(0xffFFFFFF),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 날짜&기부금액
              Container(
                  width: double.infinity,
                  height: 315,
                  color: Color(0xffFFC646),
                  child: Center(child: Text("캘린더 및 하루 식비"))),
              SizedBox(height: 40.0),

              // 아침 기록
              Text(
                '아침',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff999999),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              breakfast.isEmpty
                  ? Text("아침식사를 기록하세요")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: breakfast.length,
                      itemBuilder: (context, index) {
                        String bucket =
                            breakfast[index]; // index에 해당하는 bucket 가져오기
                        return ListTile(
                          title: Text(
                            bucket,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),

              // 점심 기록
              Text(
                '점심',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff999999),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              launch.isEmpty
                  ? Text("점심식사를 기록하세요")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: launch.length,
                      itemBuilder: (context, index) {
                        String bucket =
                            launch[index]; // index에 해당하는 bucket 가져오기
                        return ListTile(
                          title: Text(
                            bucket,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),

              //저녁 기록
              Text(
                '저녁',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff999999),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              dinner.isEmpty
                  ? Text("저녁식사를 기록하세요")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dinner.length,
                      itemBuilder: (context, index) {
                        String bucket =
                            dinner[index]; // index에 해당하는 bucket 가져오기
                        return ListTile(
                          title: Text(
                            bucket,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),

              //간식 기록
              Text(
                '간식',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff999999),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              snack.isEmpty
                  ? Text("간식을 기록하세요")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snack.length,
                      itemBuilder: (context, index) {
                        String bucket = snack[index]; // index에 해당하는 bucket 가져오기
                        return ListTile(
                          title: Text(
                            bucket,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),

              //기타
              Text(
                '기타',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff999999),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              others.isEmpty
                  ? Text("기타 식사를 입력하세요")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: others.length,
                      itemBuilder: (context, index) {
                        String bucket =
                            others[index]; // index에 해당하는 bucket 가져오기
                        return ListTile(
                          title: Text(
                            bucket,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(CupertinoIcons.pencil, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.chart_bar, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.gift, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.heart, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.person_solid, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
