import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:temp_project/const/colors.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class MealRecord {
  String name = ""; // 내용
  String meal = ""; // 식사
  String type = ""; // 방식
  int price = 0; // 금액

  MealRecord(this.name, this.type, this.price);
}

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _Record();
}

class _Record extends State<Record> {
  DateTime _selectedDay = DateTime.now();

  String formatDate = DateFormat('yyyy년 M월 d일').format(DateTime.now());

  List<String> breakfast = ['삼각김밥', '사과'];
  List<String> launch = [];
  List<String> dinner = [];
  List<String> snack = [];
  List<String> others = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: Text(
            formatDate,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: BLACK_COLOR,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        backgroundColor: Color(0xffFFFFFF),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //주간 캘린더
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WeeklyDatePicker(
                  selectedDay: _selectedDay,
                  changeDay: (value) => setState(() {
                    _selectedDay = value;
                    formatDate = DateFormat('yyyy년 M월 d일').format(value);
                  }),
                  enableWeeknumberText: false,
                  weeknumberTextColor: Colors.white,
                  backgroundColor: const Color(0xffFFFFFF),
                  weekdayTextColor: const Color(0xff444444),
                  digitsColor: Color(0xff444444),
                  selectedBackgroundColor: PRIMARY_COLOR,
                  weekdays: const ["월", "화", "수", "목", "금", "토", "일"],
                  daysInWeek: 7,
                ),
              ),

              // 기부금액&소비내역
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    color: PRIMARY_COLOR,
                  ),
                  Container(
                    width: 460,
                    height: 150,
                    margin:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40.0),

              // 아침 기록
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '아침',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              breakfast.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("아침식사를 기록하세요"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: breakfast.length,
                      itemBuilder: (context, index) {
                        String bucket =
                            breakfast[index]; // index에 해당하는 bucket 가져오기
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            color: Color(0xffF9F9F9),
                            elevation: 2,
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              leading: Text(
                                '외식',
                                style: TextStyle(color: GREY_COLOR),
                              ),
                              title: Text(
                                bucket,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Text(
                                '1200',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: GREY_COLOR,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),

              // 점심 기록
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  '점심',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              launch.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Card(
                        color: Color(0xffF9F9F9),
                        elevation: 2,
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text(
                            '점심식사를 입력하세요',
                            style: TextStyle(
                              fontSize: 17.5,
                              color: BLACK_COLOR,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: launch.length,
                      itemBuilder: (context, index) {
                        String bucket =
                            launch[index]; // index에 해당하는 bucket 가져오기
                        return ListTile(
                          title: Text(
                            bucket,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),

              //저녁 기록
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  '저녁',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              dinner.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("저녁식사를 기록하세요"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dinner.length,
                      itemBuilder: (context, index) {
                        String bucket =
                            dinner[index]; // index에 해당하는 bucket 가져오기
                        return ListTile(
                          title: Text(
                            bucket,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),

              //간식 기록
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  '간식',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              snack.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("간식을 기록하세요"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snack.length,
                      itemBuilder: (context, index) {
                        String bucket = snack[index]; // index에 해당하는 bucket 가져오기
                        return ListTile(
                          title: Text(
                            bucket,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),

              //기타
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  '기타',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              others.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("기타 식사를 입력하세요"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: others.length,
                      itemBuilder: (context, index) {
                        String bucket =
                            others[index]; // index에 해당하는 bucket 가져오기
                        return ListTile(
                          title: Text(
                            bucket,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30.0),
              //
              // 기록추가 버튼
              Container(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            height: 600,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  SizedBox(height: 10.0),
                                  Text(
                                    '기록하기',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: BLACK_COLOR,
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    '식사',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '방식',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '내용',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  color: PRIMARY_COLOR,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.add,
                    size: 24,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                ),
              ),

              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(MealRecord mealrecord) {
    return ListTile(
      onTap: () {},
      //trailing: ,
      title: Text(
        mealrecord.name,
      ),
      trailing: Text('mealrecord.price원'),
    );
  }
}
