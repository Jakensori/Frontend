import 'package:flutter/material.dart';
import 'package:temp_project/const/colors.dart';

class Join extends StatefulWidget {
  const Join({Key? key}) : super(key: key);

  @override
  State<Join> createState() => _Join();
}

class _Join extends State<Join> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('회원가입'),
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '아이디',
              ),
            ),
            SizedBox(height: 14.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '비밀번호',
              ),
            ),
            SizedBox(height: 14.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '비밀번호 확인',
              ),
            ),
            SizedBox(height: 14.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이름',
              ),
            ),
            SizedBox(height: 14.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이메일',
              ),
            ),
            SizedBox(height: 14.0),
          ],
        ),
      ),
    );
  }
}
