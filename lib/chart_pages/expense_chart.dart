import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:temp_project/const/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
//import 'package:fl_chart/fl_chart.dart';

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
  List<String> items_year = [
    '2020','2021','2022','2023'
  ];
  /*
  for({int i=2000}; i<=DateTime.now().year; i++){
    String year = i.toString();
    items_year.add(year);
  }
  */
  List<String> items_month = [
    '전체','1','2','3','4','5','6','7','8','9','10','11','12',
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller:_scrollController,
        thickness: 4.0, // 스크롤 너비
        radius: Radius.circular(8.0), // 스크롤 라운딩
        isAlwaysShown: true, // 항상 보이기 여부
        child:ListView(
          controller:_scrollController,
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
                          'Year',
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
                          'Month',
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

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(16.0),
                    side:BorderSide(width:1.0),
                  ),
                  elevation: 0.0,
                  color: PRIMARY_COLOR.withOpacity(0.1),
                  child: Container(
                    height:400.0,
                    width:double.infinity,
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(16.0),
                    side:BorderSide(width:1.0),
                  ),
                  elevation: 0.0,
                  color: PRIMARY_COLOR.withOpacity(0.1),
                  child: Container(
                    height:400.0,
                    width:double.infinity,
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(16.0),
                    side:BorderSide(width:1.0),
                  ),
                  elevation: 0.0,
                  color: PRIMARY_COLOR.withOpacity(0.1),
                  child: Container(
                    height:400.0,
                    width:double.infinity,
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(16.0),
                    side:BorderSide(width:1.0),
                  ),
                  elevation: 0.0,
                  color: PRIMARY_COLOR.withOpacity(0.1),
                  child: Container(
                    height:400.0,
                    width:double.infinity,
                  ),
                ),

              ],
            ),
          ],
        )
    );
  }
}
