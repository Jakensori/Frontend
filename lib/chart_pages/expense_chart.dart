import 'package:flutter/material.dart';
//import 'package:fl_chart/fl_chart.dart';
class ExpenseChartPage extends StatefulWidget {
  const ExpenseChartPage({Key? key}) : super(key: key);

  @override
  State<ExpenseChartPage> createState() => _ExpenseChartPageState();
}

class _ExpenseChartPageState extends State<ExpenseChartPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Text('Expense Chart Page')
    );
  }
}
