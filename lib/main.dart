//import 'dart:html';

import 'package:flutter/material.dart';

import 'package:temp_project/record.dart';
import 'package:temp_project/chart.dart';
import 'package:temp_project/donate.dart';
import 'package:temp_project/collection.dart';
import 'package:temp_project/my_page.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
//import 'package:temp_project/chart_pages/expense_chart.dart';
//import 'package:temp_project/chart_pages/meal_chart.dart';
import 'start.dart';



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
      home: Record(),
    );
  }
}