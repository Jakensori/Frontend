import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/chart_pages/calendar.dart';
import 'package:temp_project/chart_pages/expense_chart.dart';
import 'package:temp_project/chart_pages/meal_chart.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  static const List<Widget> _views = [
    Center(child: CalendarPage()),
    Center(child: ExpenseChartPage()),
    Center(child: MealChartPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:3,
      child:Scaffold(
        appBar:AppBar(
          //title: Text('chart탭 상단바'),
          //backgroundColor: Color(0xFFFFFF),
          bottom: TabBar(
          /*
            labelColor: Color(0x444444),
            unselectedLabelColor: Color(0x999999),
            indicatorWeight: 5,
            indicatorColor: Color(0x444444),*/
            tabs: [
              Tab(text: '가계부'),
              Tab(text: '식비 분석'),
              Tab(text: '식사 분석'),
            ],
          ),
        ),

        body:TabBarView(
          children: _views
        ),
      ),
    );
  }
}

/*
//차트페이지
class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  int _selectedIndex = 0;
  final List<Widget> _widgetOotions = <Widget>[
    CalendarPage(),
   // ExpenseChartPage(),
   // MealChartPage(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: _widgetOotions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.pencil, color: Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar, color: Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gift, color: Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart, color: Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person, color: Colors.black),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  void initState(){
    super.initState();
  }

  void dispose(){
    super.dispose();
  }
}
*/
