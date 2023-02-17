import 'package:flutter/material.dart';

class Record extends StatelessWidget {
  const Record({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
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
    ));
  }
}
