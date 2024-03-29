import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:temp_project/const/colors.dart';
import 'package:temp_project/record_pages/record_controller.dart';
import 'package:temp_project/record_pages/settlement.dart';
import 'package:temp_project/record_pages/settlement_controller.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import 'meal.dart';
import 'dart:async';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _Record();
}

class _Record extends State<Record> {
  DateTime _selectedDay = DateTime.now();
  String formatDate = DateFormat('yyyy년 M월 d일').format(DateTime.now());

  List<MealInfo> breakfastList = [];
  List<MealInfo> launchList = [];
  List<MealInfo> dinnerList = [];
  List<MealInfo> snackList = [];
  List<MealInfo> othersList = [];

  late Future<MealRecord> mealRecord;
  late final Future<SettlementInfo>? settleInfo;
  int today_donation = 0;
  int differ = 0;

  int formatYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
  int formatMonth = int.parse(DateFormat('M').format(DateTime.now()));
  int formatDay = int.parse(DateFormat('d').format(DateTime.now()));
  MealInfo mealInfo = new MealInfo(when: '', category: '', price: 0, memo: '');

  @override
  void initState() {
    super.initState();
    mealRecord =
        MealProvider().getMealRecord(formatYear, formatMonth, formatDay);
    settleInfo =
        SettlementProvider().getSettlement(formatYear, formatMonth, formatDay);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
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
      ),
      backgroundColor: Color(0xffFFFFFF),
      body: _Fetch(context),
      floatingActionButton: Stack(
        children: [
          // settlement button
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.2),
            child: FloatingActionButton.extended(
              onPressed: () async {
                var info = await MealProvider()
                    .getMealRecord(formatYear, formatMonth, formatDay);
                if (info.day_budget! - info.consumption! > 0) {
                  differ = info.day_budget! - info.consumption!;
                }
                settlementSheet(differ);
              },
              label: const Text(
                '하루정산',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold
                    //color: BLACK_COLOR,
                    ),
              ),
              icon: const Icon(Icons.attach_money),
              backgroundColor: PRIMARY_COLOR,
            ),
          ),

          //add record button
          Align(
            alignment:
                Alignment(Alignment.bottomRight.x, Alignment.bottomRight.y),
            child: FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    builder: (BuildContext context) {
                      return add_record(context);
                    });
              },
              label: const Text(
                '추가하기',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold
                    //color: BLACK_COLOR,
                    ),
              ),
              icon: const Icon(Icons.add),
              backgroundColor: PRIMARY_COLOR,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _Fetch(context) {
    return FutureBuilder(
        future: mealRecord,
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

  Widget buildList(snapshot) {
    breakfastList = [];
    launchList = [];
    dinnerList = [];
    snackList = [];
    othersList = [];

    for (int i = 0; i < snapshot.meal.length; i++) {
      if (snapshot.meal == null) {
        break;
      }
      switch (snapshot.meal[i].when) {
        case "아침":
          breakfastList.add(snapshot.meal[i]);
          break;
        case "점심":
          launchList.add(snapshot.meal[i]);
          break;
        case "저녁":
          dinnerList.add(snapshot.meal[i]);
          break;
        case "간식":
          snackList.add(snapshot.meal[i]);
          break;
        case "기타":
          othersList.add(snapshot.meal[i]);
          break;
      }
    }

    var differ = (snapshot.day_budget - snapshot.consumption);
    if (differ <= 0) {
      differ = 0;
    }
    return SingleChildScrollView(
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
                formatYear = int.parse(DateFormat('yyyy').format(value));
                formatMonth = int.parse(DateFormat('M').format(value));
                formatDay = int.parse(DateFormat('d').format(value));
                mealRecord = MealProvider()
                    .getMealRecord(formatYear, formatMonth, formatDay);
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
          Stack(
            children: [
              Container(
                  width: double.infinity, height: 180, color: PRIMARY_COLOR),
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
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 기부 가능 금액
                        Container(
                          child: Column(
                            children: [
                              Text(
                                '기부 가능 금액',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: GREY_COLOR,
                                ),
                              ),
                              Text(
                                '${differ.toString()} 원',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: BLACK_COLOR),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 예산
                            Container(
                                child: Column(
                              children: [
                                Text('예산',
                                    style: TextStyle(
                                        fontSize: 15, color: GREY_COLOR)),
                                Text('${snapshot.day_budget.toString()} 원',
                                    style: TextStyle(
                                        fontSize: 21, color: BLACK_COLOR)),
                              ],
                            )),

                            // 소비
                            Container(
                                child: Column(
                              children: [
                                Text('소비',
                                    style: TextStyle(
                                        fontSize: 15, color: GREY_COLOR)),
                                Text('${snapshot.consumption.toString()} 원',
                                    style: TextStyle(
                                        fontSize: 21, color: BLACK_COLOR))
                              ],
                            ))
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),

          SizedBox(height: 40.0),
          // 아침 기록
          mealTime('아침'),
          SizedBox(
            height: 5.0,
          ),
          breakfastList.isEmpty
              ? noticeRecord('아침식사')
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: breakfastList.length,
                  itemBuilder: (context, index) {
                    MealInfo breakfast = breakfastList[index];
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
                            breakfast.category.toString(),
                            style: TextStyle(fontSize: 15, color: GREY_COLOR),
                          ),
                          title: Text(breakfast.memo.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: GREY_COLOR)),
                          trailing: Text(
                            '${breakfast.price.toString()} 원',
                            style: TextStyle(fontSize: 20, color: BLACK_COLOR),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          SizedBox(height: 30.0),

          // 점심 기록
          mealTime('점심'),
          SizedBox(
            height: 5.0,
          ),
          launchList.isEmpty
              ? noticeRecord('점심식사')
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: launchList.length,
                  itemBuilder: (context, index) {
                    MealInfo launch = launchList[index];
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
                          leading: Text(launch.category.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: GREY_COLOR)),
                          title: Text(
                            launch.memo.toString(),
                            style: TextStyle(fontSize: 18, color: GREY_COLOR),
                          ),
                          trailing: Text(
                            '${launch.price.toString()} 원',
                            style: TextStyle(fontSize: 20, color: BLACK_COLOR),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          SizedBox(height: 30.0),

          //저녁 기록
          mealTime('저녁'),
          SizedBox(
            height: 5.0,
          ),
          dinnerList.isEmpty
              ? noticeRecord('저녁식사')
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dinnerList.length,
                  itemBuilder: (context, index) {
                    MealInfo dinner = dinnerList[index];
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
                          leading: Text(dinner.category.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: GREY_COLOR)),
                          title: Text(dinner.memo.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: GREY_COLOR)),
                          trailing: Text(
                            '${dinner.price.toString()} 원',
                            style: TextStyle(fontSize: 20, color: BLACK_COLOR),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          SizedBox(height: 30.0),

          //간식 기록
          mealTime('간식'),
          SizedBox(
            height: 5.0,
          ),
          snackList.isEmpty
              ? noticeRecord('간식')
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snackList.length,
                  itemBuilder: (context, index) {
                    MealInfo snack = snackList[index];
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
                          leading: Text(snack.category.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: GREY_COLOR)),
                          title: Text(
                            snack.memo.toString(),
                            style: TextStyle(fontSize: 18, color: GREY_COLOR),
                          ),
                          trailing: Text(
                            '${snack.price.toString()} 원',
                            style: TextStyle(fontSize: 20, color: BLACK_COLOR),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          SizedBox(height: 30.0),

          //기타
          mealTime('기타'),
          SizedBox(
            height: 5.0,
          ),
          othersList.isEmpty
              ? noticeRecord('기타 식사')
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: othersList.length,
                  itemBuilder: (context, index) {
                    MealInfo others = othersList[index];
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
                          leading: Text(others.category.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: GREY_COLOR)),
                          title: Text(
                            others.memo.toString(),
                            style: TextStyle(fontSize: 18, color: GREY_COLOR),
                          ),
                          trailing: Text(
                            '${others.price.toString()} 원',
                            style: TextStyle(fontSize: 20, color: BLACK_COLOR),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          SizedBox(height: 120.0),
        ],
      ),
    );
  }

  Future<void> settlementSheet(differ) {
    return showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 800,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 30.0),
                  child: Column(
                    children: [
                      Text('하 루  정 산',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: BLACK_COLOR,
                          )),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Text('기부 가능 금액',
                              style: TextStyle(
                                  fontSize: 20.0, color: BLACK_COLOR)),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 0.0),
                              child: Text('${differ} 원',
                                  style: TextStyle(
                                      fontSize: 20.0, color: BLACK_COLOR)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      differ != 0
                          ? Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 0.0),
                                    child: TextField(
                                      onChanged: (text) {
                                        setState(() {
                                          today_donation = int.parse(text);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Text('원 기부하기',
                                    style: TextStyle(
                                        fontSize: 20.0, color: BLACK_COLOR)),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              child: Text(
                                "오늘은 기부할 수 있는 금액이 없어요",
                                style: TextStyle(
                                    color: BLACK_COLOR,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )),
                      SizedBox(height: 80),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              print("오늘 기부 금액: $today_donation 원");
                              SettlementProvider()
                                  .postSettlement(today_donation);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: PRIMARY_COLOR,
                                fixedSize: Size(250, 20),
                                alignment: Alignment.center),
                            child: Text(
                              '기부금 정산하기',
                              style: TextStyle(
                                  color: BLACK_COLOR,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            )),
                      )
                    ],
                  )),
            ),
          );
        });
  }

  SingleChildScrollView add_record(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 800,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(height: 10.0),
              Container(
                width: double.maxFinite,
                child: Text(
                  '기록하기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: BLACK_COLOR,
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // 식사 체크
              Text(
                '식사',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 19,
                  color: GREY_COLOR,
                ),
              ),
              CustomCheckBoxGroup(
                selectedColor: PRIMARY_COLOR,
                unSelectedColor: Colors.white,
                buttonTextStyle: ButtonTextStyle(
                    selectedColor: BLACK_COLOR,
                    unSelectedColor: BLACK_COLOR,
                    textStyle: TextStyle(fontSize: 15, color: BLACK_COLOR)),
                buttonValuesList: ["아침", "점심", "저녁", "간식", "기타"],
                buttonLables: ["아침", "점심", "저녁", "간식", "기타"],
                checkBoxButtonValues: (when) {
                  mealInfo.when = when.toString().substring(1, 3);
                },
                spacing: 2,
                horizontal: false,
                enableButtonWrap: true,
                width: 60,
                padding: 5,
                enableShape: true,
              ),
              SizedBox(height: 13.0),

              //방식 체크
              Text(
                '방식',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 19,
                  color: Color(0xff999999),
                ),
              ),
              CustomCheckBoxGroup(
                selectedColor: PRIMARY_COLOR,
                unSelectedColor: Colors.white,
                buttonTextStyle: ButtonTextStyle(
                    selectedColor: BLACK_COLOR,
                    unSelectedColor: BLACK_COLOR,
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: BLACK_COLOR,
                    )),
                buttonValuesList: ["집밥", "외식", "배달", "카페", "기타"],
                buttonLables: ["집밥", "외식", "배달", "카페", "기타"],
                checkBoxButtonValues: (category) {
                  mealInfo.category = category.toString().substring(1, 3);
                },
                spacing: 2,
                horizontal: false,
                enableButtonWrap: true,
                width: 60,
                padding: 5,
                enableShape: true,
              ),
              SizedBox(height: 15.0),

              // 가격 입력
              Text(
                '금액',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 19,
                  color: Color(0xff999999),
                ),
              ),
              SizedBox(height: 10.0),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 00.0, vertical: 0.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: '금액',
                    // labelStyle:
                    //     TextStyle(fontSize: 19, color: GREY_COLOR),
                  ),
                  onChanged: (text) {
                    setState(() {
                      mealInfo.price = int.parse(text);
                    });
                  },
                ),
              ),

              SizedBox(height: 15.0),

              // 내용 입력
              Text(
                '내용',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 19,
                  color: Color(0xff999999),
                ),
              ),
              SizedBox(height: 10.0),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 00.0, vertical: 0.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    //labelText: '내용',
                    labelStyle: TextStyle(fontSize: 19, color: GREY_COLOR),
                  ),
                  onChanged: (text) {
                    setState(() {
                      mealInfo.memo = text;
                    });
                  },
                ),
              ),

              SizedBox(height: 15.0),

              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      await MealProvider().postMealRecord(mealInfo);
                      Navigator.pop(context);
                      setState(() {
                        mealRecord = MealProvider()
                            .getMealRecord(formatYear, formatMonth, formatDay);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: PRIMARY_COLOR,
                        fixedSize: Size(250, 20),
                        alignment: Alignment.center),
                    child: Text(
                      '저장하기',
                      style: TextStyle(
                          color: BLACK_COLOR,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding noticeRecord(String meal) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        color: Color(0xffF9F9F9),
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(
            '$meal를 입력하세요',
            style: TextStyle(
              fontSize: 17.5,
              color: BLACK_COLOR,
            ),
          ),
        ),
      ),
    );
  }

  Padding mealTime(String when) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        '$when',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 17, color: GREY_COLOR, fontWeight: FontWeight.w500),
      ),
    );
  }
}
