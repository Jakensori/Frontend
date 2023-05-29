import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:temp_project/const/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'package:temp_project/ExpenseChart.dart';
import 'package:intl/intl.dart';


class ExpenseChartPage extends StatefulWidget {
  const ExpenseChartPage({Key? key}) : super(key: key);

  @override
  State<ExpenseChartPage> createState() => _ExpenseChartPageState();
}


class _ExpenseChartPageState extends State<ExpenseChartPage> {
  final int currentYear = DateTime.now().year;
  final int currentMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  Future<ExpenseChart>? expenseChart;

  @override
  void initState(){
    super.initState();
    expenseChart = ExpenseProvider().fetchExpenseChart(currentYear,currentMonth);
  }

  final ScrollController _scrollController = ScrollController();
  String? _value1;
  String? _value2;
  final List<String> items_year = ['2020', '2021', '2022', '2023'];
  final List<String> items_month = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12',
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                FutureBuilder<ExpenseChart>(
                  //통신데이터 가져오기
                  future: expenseChart,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return buildList(snapshot.data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}에러!!");
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildList(snapshot) {

    String str_homemade = snapshot.homemade.toString();
    String str_eating_out = snapshot.eating_out.toString();
    String str_delivery = snapshot.delivery.toString();
    String str_cafe = snapshot.cafe.toString();
    String str_etc = snapshot.etc.toString();

    String str_amt_homemade = snapshot.amt_homemade.toString();
    String str_amt_eating_out = snapshot.amt_eating_out.toString();
    String str_amt_delivery = snapshot.amt_delivery.toString();
    String str_amt_cafe = snapshot.amt_cafe.toString();
    String str_amt_etc = snapshot.amt_etc.toString();

    //total_count==0, no data일때 보여줄 pie char 데이터0
    List<PieChartSectionData> _chartSections0 = [
      PieChartSectionData(
        value: 100,
        color: PRIMARY_COLOR,
        title: 'no data',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
    ];

    //pie chart 데이터1 (식사 종류(횟수))
    List<PieChartSectionData> _chartSections1 = [
      PieChartSectionData(
        value: snapshot.homemade.toDouble(),
        color: PRIMARY_COLOR,
        title: '집밥 ($str_homemade회)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
      PieChartSectionData(
        value: snapshot.eating_out.toDouble(),
        color: PRIMARY_COLOR.withOpacity(0.5),
        title: '외식 ($str_eating_out회)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
      PieChartSectionData(
        value: snapshot.delivery.toDouble(),
        color: Colors.yellow,
        title: '배달 ($str_delivery회)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
      PieChartSectionData(
        value: snapshot.cafe.toDouble(),
        color: Colors.orange,
        title: '카페 ($str_cafe회)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
      PieChartSectionData(
        value: snapshot.etc.toDouble(),
        color: Colors.orange.withOpacity(0.5),
        title: '기타 ($str_etc회)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
    ];

//pie chart 데이터2
    List<PieChartSectionData> _chartSections2 = [
      PieChartSectionData(
        value: snapshot.amt_homemade.toDouble(),
        color: PRIMARY_COLOR,
        title: '집밥 ($str_amt_homemade원)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
      PieChartSectionData(
        value: snapshot.amt_eating_out.toDouble(),
        color: PRIMARY_COLOR.withOpacity(0.5),
        title: '외식 ($str_amt_eating_out원)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
      PieChartSectionData(
        value: snapshot.amt_delivery.toDouble(),
        color: Colors.yellow,
        title: '배달 ($str_amt_delivery원)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
      PieChartSectionData(
        value: snapshot.amt_cafe.toDouble(),
        color: Colors.orange,
        title: '카페 ($str_amt_cafe원)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
      PieChartSectionData(
        value: snapshot.amt_etc.toDouble(),
        color: Colors.orange.withOpacity(0.5),
        title: '기타 ($str_amt_etc원)',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: WHITE_COLOR,
        ),
      ),
    ];

    return Scrollbar(
        controller: _scrollController,
        thickness: 4.0, // 스크롤 너비
        radius: Radius.circular(8.0), // 스크롤 라운딩
        isAlwaysShown: true, // 항상 보이기 여부
        child: ListView(
          shrinkWrap:true,
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentYear.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: BLACK_COLOR,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    items: items_year
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: BLACK_COLOR,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: _value1,
                    onChanged: (value) {
                      setState(() {
                        _value1 = value as String;
                        selectedYear = int.parse(value);
                      });
                      //연도 변경시 get 재호출
                      expenseChart = ExpenseProvider().fetchExpenseChart(selectedYear,selectedMonth);
                      print('연도 변경으로 재호출됨');
                    },
                    icon: const Icon(
                      Icons.expand_more,
                    ),
                    iconSize: 16,
                    iconEnabledColor: BLACK_COLOR,
                    iconDisabledColor: BLACK_COLOR,
                    buttonHeight: 70,
                    buttonWidth: 150,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 20),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: WHITE_COLOR,
                      ),
                      //color: Colors.redAccent,
                    ),
                    buttonElevation: 0,
                    itemHeight: 20,
                    itemPadding: const EdgeInsets.only(left: 20, right: 20),
                    dropdownMaxHeight: 200,
                    dropdownWidth: 200,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: WHITE_COLOR,
                    ),
                    dropdownElevation: 0,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(
                          currentMonth.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: BLACK_COLOR,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    items: items_month
                        .map((item2) => DropdownMenuItem<String>(
                              value: item2,
                              child: Text(
                                item2,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: BLACK_COLOR,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: _value2,
                    onChanged: (value) {
                      setState(() {
                        _value2 = value as String;
                        selectedMonth = int.parse(value);
                      });
                      //달 변경시 get재호출
                      expenseChart = ExpenseProvider().fetchExpenseChart(selectedYear, selectedMonth);
                      print('달 변경으로 재호출됨');
                    },
                    icon: const Icon(
                      Icons.expand_more,
                    ),
                    iconSize: 16,
                    iconEnabledColor: BLACK_COLOR,
                    iconDisabledColor: BLACK_COLOR,
                    buttonHeight: 70,
                    buttonWidth: 150,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 20),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: WHITE_COLOR,
                      ),
                      //color: Colors.redAccent,
                    ),
                    buttonElevation: 0,
                    itemHeight: 20,
                    itemPadding: const EdgeInsets.only(left: 20, right: 20),
                    dropdownMaxHeight: 200,
                    dropdownWidth: 200,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: WHITE_COLOR,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                  ),
                ),
              ],
            ),

            //차트 2개 column
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 270.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Flexible(
                              child: Text(
                                '< 식사 종류 (횟수) >',
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),
                              ),
                              flex: 1),
                          Flexible(
                              child: PieChart(
                                PieChartData(
                                  sections: snapshot.total_count == 0 ? _chartSections0 : _chartSections1,
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  centerSpaceRadius: 40,
                                  sectionsSpace: 0,
                                ),
                              ),
                              flex: 9),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 270.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Flexible(
                              child: Text(
                                '< 식사 종류 (비용) >',
                                style: TextStyle(fontSize: 15, fontWeight:FontWeight.w800),
                              ),
                              flex: 1),
                          Flexible(
                              child: PieChart(
                                PieChartData(
                                  sections: snapshot.total_count == 0 ? _chartSections0 : _chartSections2,
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  centerSpaceRadius: 40,
                                  sectionsSpace: 0,
                                ),
                              ),
                              flex: 9),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
