import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:temp_project/const/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
//pie chart 데이터1
List<PieChartSectionData> _chartSections1 = [
  PieChartSectionData(
    value: 46,
    color: PRIMARY_COLOR,
    title: '외식(49회)',
    radius: 60,
    titleStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  PieChartSectionData(
    value: 29,
    color: Colors.orange,
    title: '집밥(18회)',
    radius: 60,
    titleStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  PieChartSectionData(
    value: 25,
    color: Colors.yellow,
    title: '배달(13회)',
    radius: 60,
    titleStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
];

//pie chart 데이터2
List<PieChartSectionData> _chartSections2 = [
  PieChartSectionData(
    value: 528400,
    color: PRIMARY_COLOR,
    title: '외식(528,400원)',
    radius: 60,
    titleStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  PieChartSectionData(
    value: 361000,
    color: Colors.orange,
    title: '배달(361,000원)',
    radius: 60,
    titleStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  PieChartSectionData(
    value: 28900,
    color: Colors.yellow,
    title: '카페(28,900원)',
    radius: 60,
    titleStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
];

//bar chart 데이터 클래스
class TimesDataItem {
  int x;
  double y1;
  double y2;

  TimesDataItem({required this.x, required this.y1, required this.y2});
}
class ExpenseDataItem {
  int x;
  double y1;
  double y2;

  ExpenseDataItem({required this.x, required this.y1, required this.y2});
}

class ExpenseChartPage extends StatefulWidget {
  const ExpenseChartPage({Key? key}) : super(key: key);

  @override
  State<ExpenseChartPage> createState() => _ExpenseChartPageState();
}

class _ExpenseChartPageState extends State<ExpenseChartPage> {
  final ScrollController _scrollController = ScrollController();

  //String _date = '${DateTime.now().year} - ${DateTime.now().month}';
  String? _value1;
  String? _value2;
  final List<String> items_year = ['2020', '2021', '2022', '2023'];
  String? _selectedYear;

  /*
  for({int i=2000}; i<=DateTime.now().year; i++){
    String year = i.toString();
    items_year.add(year);
  }
  */
  final List<String> items_month = [
    '전체',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  String? _selectedMonth;

  //bar chart 데이터
  final List<TimesDataItem> _myData1 = List.generate(
      5,
      (index) => TimesDataItem(
            x: 1,
            y1: 113,
            y2: 49
          ));

  final List<ExpenseDataItem> _myData2 = List.generate(
      5,
          (index) => ExpenseDataItem(
        x: 0,
        y1: 1521100,
        y2: 528400
      ));

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: _scrollController,
        thickness: 4.0,
        // 스크롤 너비
        radius: Radius.circular(8.0),
        // 스크롤 라운딩
        isAlwaysShown: true,
        // 항상 보이기 여부
        child: ListView(
          controller: _scrollController,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '2023',
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
                      });
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
                      children: const [
                        Text(
                          '5',
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
                      });
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

            //차트 4개 column
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
                                '식사 종류 (횟수)',
                                style: TextStyle(fontSize: 15),
                              ),
                              flex: 1),
                          Flexible(
                              child: PieChart(
                                PieChartData(
                                  sections: _chartSections1,
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
                                '식사 종류 (비용)',
                                style: TextStyle(fontSize: 15),
                              ),
                              flex: 1),
                          Flexible(
                              child: PieChart(
                                PieChartData(
                                  sections: _chartSections2,
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
                                '식사 종류 (횟수)',
                                style: TextStyle(fontSize: 15),
                              ),
                              flex: 1),
                          Flexible(
                              child: BarChart(BarChartData(
                                  borderData: FlBorderData(
                                      border: const Border(
                                    top: BorderSide.none,
                                    right: BorderSide.none,
                                    left: BorderSide(width: 1),
                                    bottom: BorderSide(width: 1),
                                  )),
                                  groupsSpace: 10,
                                  barGroups: _myData1
                                      .map((dataItem) => BarChartGroupData(
                                              x: dataItem.x,
                                              barRods: [
                                                BarChartRodData(
                                                    toY: dataItem.y1,
                                                    width: 5,
                                                    color: PRIMARY_COLOR),
                                                BarChartRodData(
                                                    toY: dataItem.y2,
                                                    width: 5,
                                                    color: Colors.orange),
                                              ]))
                                      .toList())),
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
                                '식사 종류 (비용)',
                                style: TextStyle(fontSize: 15),
                              ),
                              flex: 1),
                          Flexible(
                              child: BarChart(BarChartData(
                                  borderData: FlBorderData(
                                      border: const Border(
                                        top: BorderSide.none,
                                        right: BorderSide.none,
                                        left: BorderSide(width: 1),
                                        bottom: BorderSide(width: 1),
                                      )),
                                  groupsSpace: 10,
                                  barGroups: _myData2
                                      .map((dataItem) => BarChartGroupData(
                                      x: dataItem.x,
                                      barRods: [
                                        BarChartRodData(
                                            toY: dataItem.y1,
                                            width: 5,
                                            color: PRIMARY_COLOR),
                                        BarChartRodData(
                                            toY: dataItem.y2,
                                            width: 5,
                                            color: Colors.orange),
                                      ]))
                                      .toList())),
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
