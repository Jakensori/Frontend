import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  //const Chart({Key? key}) : super(key: key);

  static const List<Widget> _views = [
    const Center(child: const Text('tab1')),
    const Center(child: const Text('tab2')),
    const Center(child: const Text('tab3')),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:3,
      child:Scaffold(
        appBar:AppBar(
          //title: Text('chart탭 상단바'),
          //backgroundColor: Color(0xffffff),
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
