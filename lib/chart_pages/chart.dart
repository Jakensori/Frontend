import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/chart_pages/monthly_calendar.dart';
import 'package:temp_project/chart_pages/expense_chart.dart';
import 'package:temp_project/const/colors.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  static List<Widget> _views = [
    Center(child: Calendar()),
    Center(child: ExpenseChartPage()),
  ];

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: IconButton(
                icon: Icon(CupertinoIcons.mail, color: BLACK_COLOR),
                iconSize: 35.0,
                onPressed: () {
                  // 아이콘을 클릭했을 때 수행할 동작을 정의합니다.
                },
              ),
            ),
          ],
          backgroundColor: WHITE_COLOR,
          bottom: TabBar(
            labelColor: BLACK_COLOR,
            unselectedLabelColor: GREY_COLOR,
            indicatorWeight: 2,
            indicatorColor: BLACK_COLOR,
            tabs: const [
              Tab(
                text: '가계부',
              ),
              Tab(text: '식비 분석'),
            ],
          ),
        ),
        body: TabBarView(children: Chart._views),
      ),
    );
  }
}
