import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/budget_controller.dart';
import 'package:temp_project/collection.dart';
import 'package:temp_project/user_control/user_controller.dart';

import 'const/colors.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: Text(
            '마이페이지',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: BLACK_COLOR,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(CupertinoIcons.person_alt_circle,
                        color: BLACK_COLOR, size: 90),
                    Container(width: 20),
                    Text(
                      '권은정',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(height: 1.0, width: 500.0, color: GREY_COLOR),
              SizedBox(height: 30),
              Text(
                '나의 생활',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BudgetScreen(),
                        ),
                      );
                    },
                    child: Text(
                      '한 달 식비 예산 입력',
                      style: TextStyle(fontSize: 16, color: BLACK_COLOR),
                    ),
                  ),
                  Container(width: 5),
                  Icon(CupertinoIcons.arrow_right_circle,
                      color: BLACK_COLOR, size: 23),
                ],
              ),
              SizedBox(height: 35),
              Text(
                '나의 기부',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '기부금 적립 퍼센트 입력',
                      style: TextStyle(fontSize: 16, color: BLACK_COLOR),
                    ),
                  ),
                  Container(width: 5),
                  Icon(CupertinoIcons.arrow_right_circle,
                      color: BLACK_COLOR, size: 23),
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // 기부 내역 보기 화면으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonationHistoryScreen(),
                        ),
                      );
                    },
                    child: Text(
                      '기부 내역 보기',
                      style: TextStyle(fontSize: 16, color: BLACK_COLOR),
                    ),
                  ),
                  Container(width: 5),
                  Icon(CupertinoIcons.arrow_right_circle,
                      color: BLACK_COLOR, size: 23),
                ],
              ),
              SizedBox(height: 35),
              Text(
                '도움말 ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'FAQ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '공지사항',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonationHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: Text(
            '기부 내역',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              letterSpacing: 1.2,
              color: BLACK_COLOR,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '기부 내역을 여기에 추가할 예정입니다.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class BudgetScreen extends StatelessWidget {
  TextEditingController budgetControl = TextEditingController();
  int day_budget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: Text(
            '식비 수정하기',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              letterSpacing: 1.2,
              color: BLACK_COLOR,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 30),
        child: Column(
          children: [
            Text(
              '한 달 식비를 입력하세요',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 15.0),
            TextField(
              controller: budgetControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '식비',
              ),
              onChanged: (text) {
                int? budget = int.parse(text);
                day_budget = CalculateBudget(budget);
              },
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          title: Text('하루에',
                              style: TextStyle(
                                fontSize: 18.0,
                              )),
                          content: SingleChildScrollView(
                            child: Text(
                              '$day_budget 원을 쓸 수 있어요 !',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                await budgetProvider()
                                    .patchBudget(int.parse(budgetControl.text));

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MyPage()),
                                    (route) => false);
                              },
                              child: Text(
                                '확인',
                                style: TextStyle(color: GREY_COLOR),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('취소',
                                  style: TextStyle(color: GREY_COLOR)),
                            ),
                          ],
                        );
                      },
                    );

                    //Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                      fixedSize: Size(50, 20),
                      alignment: Alignment.center),
                  child: Text(
                    '확인',
                    style: TextStyle(
                        color: BLACK_COLOR,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class NoticesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFC646),
        title: Text('공지사항'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '공지사항을 여기에 추가합니다.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

int CalculateBudget(int budget) {
  print(budget);
  return (budget ~/ 30);
}
