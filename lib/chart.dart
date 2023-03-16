import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/chart_pages/monthly_calendar.dart';
import 'package:temp_project/chart_pages/expense_chart.dart';
import 'package:temp_project/chart_pages/meal_chart.dart';
import 'package:temp_project/const/colors.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  static List<Widget> _views = [
    Center(child: Calendar()),
    Center(child: ExpenseChartPage()),
    Center(child: MealChartPage()),
  ];

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:3,
      child:Scaffold(
        appBar:AppBar(
          //title: Text('chart탭 상단바'),
          backgroundColor: WHITE_COLOR,
          bottom: TabBar(

            labelColor: BLACK_COLOR,
            unselectedLabelColor: GREY_COLOR,
            indicatorWeight: 3,
            indicatorColor: BLACK_COLOR,

            tabs: const [
              Tab(text: '가계부',),
              Tab(text: '식비 분석'),
              Tab(text: '식사 분석'),
            ],
          ),
        ),

        body:TabBarView(
          children: Chart._views
        ),
      ),
    );
  }
}