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
          backgroundColor: Color(0xffFFFFFF),
          title: Text(
            '가입하기',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: BLACK_COLOR,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        backgroundColor: Color(0xffFFFFFF),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '아이디',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호 확인',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '이름',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  //cursorHeight: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '이메일',
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  height: 40.0,
                  margin: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                    child: Text('회원가입',
                        style: TextStyle(fontSize: 17, color: BLACK_COLOR)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
