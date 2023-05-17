import 'package:flutter/material.dart';
import 'package:temp_project/const/colors.dart';
import 'user_control/login.dart';
import 'user_control/join.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFFFFF),
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
                SizedBox(height: 50.0),
                Text(
                  'PASS\nthe\nMEAL',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60.0),
                Container(
                  width: double.infinity,
                  height: 40.0,
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                    child: Text('로그인하기',
                        style: TextStyle(fontSize: 17, color: BLACK_COLOR)),
                  ),
                ),
                SizedBox(height: 18.0),
                Container(
                  width: double.infinity,
                  height: 40.0,
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Join()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                    child: Text('회원가입하기',
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
