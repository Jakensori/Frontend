import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Savings extends StatelessWidget {
  const Savings({Key? key}) : super(key: key);

  @override
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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(5, 100, 180, 5),
            child: Text(
              '나의 기부저금통',
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

          Container(
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
              ]))))
        ],
      ),
    );
  }
}

class Square extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: Text('저금 내역 ',
          style: TextStyle(
            fontSize: 14, // 폰트 크기
            fontWeight: FontWeight.w500, // 폰트 두께
            color: Colors.black,
          )),
    );
  }
}

class Square2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: Text('저금 내역 ',
          style: TextStyle(
            fontSize: 14, // 폰트 크기
            fontWeight: FontWeight.w500, // 폰트 두께
            color: Colors.black,
          )),
    );
  }
}
