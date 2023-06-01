
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/budget_controller.dart';
import 'package:temp_project/notification.dart';
import 'package:temp_project/notification_controller.dart';
import 'package:temp_project/user_control/user_controller.dart';
import 'package:http/http.dart' as http;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: WHITE_COLOR,
        actions:[
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: IconButton(
              icon: Icon(CupertinoIcons.mail, color: BLACK_COLOR),
              iconSize: 35.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Notifications(),
                  ),
                );
                },
            ),
          ),
        ],
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
                        color:BLACK_COLOR, size: 90),
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
              Row(
                children: [
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      'FAQ   ',
                      style: TextStyle(fontSize: 16, color: BLACK_COLOR),
                    ),
                  ),
                  //Container(width: 5),
                  Icon(CupertinoIcons.arrow_right_circle,
                      color: BLACK_COLOR, size: 23),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      '공지사항',
                      style: TextStyle(fontSize: 16,color: BLACK_COLOR),
                    ),
                  ),
                  Container(width: 5),
                  Icon(CupertinoIcons.arrow_right_circle,
                      color: BLACK_COLOR, size: 23),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _Notifications();
}

class _Notifications extends State<Notifications> {
  late final Future<List<Noti>>? alarmList;

  @override
  void initState() {
    super.initState();
    alarmList = NotiProvider().getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: Icon(
            CupertinoIcons.mail,
            color: BLACK_COLOR,
            size: 40,
          ),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              color: BLACK_COLOR,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            _Fetch(context),
          ],
        ),
      ),
    );
  }

  Widget _Fetch(context) {
    return FutureBuilder(
        future: alarmList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              return buildList(snapshot.data);
            }
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        });
  }


  bool _isLoading = false;
  String _dialogData = '';
  void _showDialog(BuildContext context, int selectedIndex) async {
    // NotiProvider 인스턴스 생성
    NotiProvider notiProvider = NotiProvider();

    // getNotification 함수 호출 및 결과 사용
    try {
      List<Noti> notificationList = await notiProvider.getNotification();

      // 선택한 인덱스에 해당하는 데이터 가져오기
      Noti selectedNoti = notificationList.elementAt(selectedIndex);

      // 다이얼로그 창에 데이터 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(selectedNoti.title ?? '',style: TextStyle(fontSize:18, fontWeight: FontWeight.bold),),
            //title: Text(''),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.0),
                Image.network(selectedNoti.image ?? ''),
                SizedBox(height: 20.0),
                Text('${selectedNoti.content ?? ''}'),
                SizedBox(height: 40.0),
                Text('${selectedNoti.createdAt ?? ''}'),
                SizedBox(height: 10.0),
                Text('${selectedNoti.foundation ?? ''} 드림',textAlign: TextAlign.end),
              ],
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0), // 컨텐츠 주위의 여백 설정
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('닫기',
                  style: TextStyle(
                  fontSize: 18, // 텍스트 크기 조절
                ),),
                style: TextButton.styleFrom(
                  primary: PRIMARY_COLOR, // 버튼 텍스트 색상
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // 요청에 문제가 발생한 경우의 예외 처리
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  bool _selected = false;
  //List<bool> _selectedList = []; // 선택 상태를 저장할 리스트
  List<bool> _selectedList = List<bool>.filled(10, false);
  Widget buildList(snapshot) {
    //_selectedList = List.generate(snapshot.length, (_) => false);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: ListTile(
                    dense: false,
                    selected: _selectedList[index],
                    onTap: () {
                      print(_selectedList);
                      _showDialog(context, snapshot[index].id-1);
                      setState(() {
                        _selectedList = List<bool>.filled(snapshot.length, false); // 모든 타일의 선택 상태를 초기화
                        _selected=true;
                        _selectedList[index] = true; // 해당 인덱스의 선택 상태를 반전시킴
                        //print(_selectedList);
                        //print(_selected);
                      });
                      //print(_selectedList);
                      //print(_selected);
                    },
                    tileColor: _selectedList[index] ? Colors.white : Color.fromARGB(255, 255, 246, 203),
                    title: Text(
                      '${snapshot[index].title.toString()}',
                      style: TextStyle(fontSize: 19, color: BLACK_COLOR),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${snapshot[index].foundation.toString()}',
                          style: TextStyle(fontSize: 16, color: GREY_COLOR),
                        ),
                        Text(snapshot[index].createdAt.toString()),
                        //Text('', style: TextStyle(fontSize: 2)),
                      ],
                    ),
                    visualDensity: VisualDensity(horizontal: 0, vertical: -1),
                  ),
                );
              },
              separatorBuilder: (BuildContext ctx, int idx) {
                return Divider();
              },
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('한 달 식비  ', style: TextStyle(fontSize: 20)),
                Text('400000원', style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height: 20.0),
            Container(height: 1.0, width: 500.0, color: GREY_COLOR),
            SizedBox(height: 30.0),
            /* Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '한 달 식비를 입력하세요',
                style: TextStyle(fontSize: 20),
              ),
            ),*/
            SizedBox(height: 15.0),
            TextField(
              controller: budgetControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '한 달 식비를 입력하세요',
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

                                /*
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MyPage()),
                                    (route) => false);*/
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
                    '수정하기',
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
