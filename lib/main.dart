//import 'dart:html';

import 'package:flutter/material.dart';
import 'chart.dart';
import 'start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chart(),
    );
  }
}
      /*
      Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFFFFF),
          /*title: Text(
            '로그인',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: Color(0xff000000),
            ),
          ),*/
          centerTitle: true,
          elevation: 0.0,
        ),
        backgroundColor: Color(0xffFFFFFF),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                ),
                Text(
                  '내끼\n니끼',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                /*
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '이메일',
                  ),
                ),
                SizedBox(height: 14.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호',
                  ),
                ),
                */
                Container(
                  width: double.infinity,
                  height: 40.0,
                  margin: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff60695B),
                    ),
                    child: Text('로그인'),
                  ),
                ),
                SizedBox(height: 14.0),
                Text(
                  '비밀번호를 잊어버리셨나요?',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/