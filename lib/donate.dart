import 'package:flutter/material.dart';
import 'package:temp_project/savings.dart';

class Donate extends StatelessWidget {
  const Donate({Key? key}) : super(key: key);

  get width => null;

  @override
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
                '저금 내역 보기',
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
                  MaterialPageRoute(builder: (context) => Savings()),
                );
              },
            ),
          )
        ],
      )),
    ));
  }
}
