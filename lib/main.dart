//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:temp_project/record_pages/record.dart';
import 'package:temp_project/chart_pages/chart.dart';

import 'package:temp_project/collection_pages/collection.dart';
import 'package:temp_project/my_page.dart';

import 'package:temp_project/start.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'donate_pages/donate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomePage(),
      //home: StartPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Record(),
    Chart(),
    DonatingPage(
      title: '',
    ),
    Collection(),
    MyPage(
        //myDonations: '',
        //myLife: '',
        //name: '',
        ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.pencil, color: Colors.black),
              label: 'record'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_bar, color: Colors.black),
              label: 'chart'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.gift, color: Colors.black),
              label: 'donate'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart, color: Colors.black),
              label: 'collection'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person, color: Colors.black),
              label: 'my page'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
