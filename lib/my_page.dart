import 'package:flutter/material.dart';
/*
class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/
import 'package:flutter/material.dart';
import 'package:temp_project/collection.dart';


class MyPage extends StatelessWidget {
  /*final String name;
  final String myLife;
  final String myDonations;*/

  MyPage(
      /*{
    required this.name,
    required this.myLife,
    required this.myDonations,
  }*/
      );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color(0xffFFC646),

        title: Text(
          '마이페이지',
          style: TextStyle(
            fontSize: 25, // 폰트 크기
            fontWeight: FontWeight.bold, // 폰트 두께
            color: Colors.black, // 폰트 색상
          ),
        ),

        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(

              //'이름: $name',
              '이름: \n',

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(

              //'나의 생활: $myLife',
              '나의 생활: ',

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(

              '- 한 달 식비 예산 입력\n\n',

              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(

              //'나의 기부: $myDonations',
              '나의 기부: ',

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(

              '- 기부금 적립 퍼센트 입력\n',

              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
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

                '- 기부 내역 보기\n',

                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),

            Text(
              //'나의 기부: $myDonations',
              '도움말 ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '- FAQ\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '- 공지사항\n',
              style: TextStyle(fontSize: 16),
            ),
            /*
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                // 도움말 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Collection(),
                  ),
                );
              },
              child: Text('도움말'),

            ),*/

          ],
        ),
      ),
    );
  }
}

class DonationHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기부 내역'),

        backgroundColor: Color(0xffFFC646),

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

class FaqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '자주 묻는 질문을 여기에 추가합니다.',
          style: TextStyle(fontSize: 20),
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