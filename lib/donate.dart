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
          '기부 어쩌고',
          style: TextStyle(
            fontSize: 25, // 폰트 크기
            fontWeight: FontWeight.bold, // 폰트 두께
            color: Colors.black, // 폰트 색상
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 500,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 140, 180, 5),
              child: TextButton(
                child: Text(
                  '저금 내역 보기',
                  style: TextStyle(
                    fontSize: 14, // 폰트 크기
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
            ),
          ),
        ],
      ),
    ));
  }
}
//Stack을 사용해서 다시 구현 예정..