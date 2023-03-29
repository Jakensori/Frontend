import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:temp_project/const/colors.dart';
import 'dart:async';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:temp_project/MealChart.dart';

class MealChartPage extends StatefulWidget {
  MealChartPage({Key? key}) : super(key: key);

  final Color barBackgroundColor = PRIMARY_COLOR.withOpacity(0.1);
  final Color barColor = PRIMARY_COLOR;
  final Color touchedBarColor = GREY_COLOR;

  @override
  State<MealChartPage> createState() => _MealChartPageState();
}

class _MealChartPageState extends State<MealChartPage> {
  Future<MealChart>? mealChart;
  double BreakfastCounts=0;
  double LunchCounts =0;
  double DinnerCounts =0;

  @override
  void initState() {
    super.initState();
    mealChart = MealProvider().fetchMealChart();
  }

  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  bool isPlaying = false;

  String? _value1;
  String? _value2;
  List<String> items_year = ['2020 년', '2021 년', '2022 년', '2023 년'];
  List<String> items_month = ['전체', '1 월', '2 월', '3 월', '4 월','5 월', '6 월','7 월', '8 월', '9 월', '10 월', '11 월', '12 월'];

  double getBreakfastCounts(snapshot){
    for (int i=0;i<snapshot.record_byTime.length();i++){
      if(snapshot.record_byTime[i]=='아침'){
        BreakfastCounts++;
      }
    }
    return BreakfastCounts;
  }

  double getLunchCounts(snapshot){
    for (int i=0;i<snapshot.record_byTime.lenght();i++){
      if(snapshot.record_byTime[i]=='점심'){
        LunchCounts++;
      }
    }
    return LunchCounts;
  }
  double getDinnerCounts(snapshot){
    for (int i=0;i<snapshot.record_byTime.lenght();i++){
      if(snapshot.record_byTime[i]=='저녁'){
        DinnerCounts++;
      }
    }
    return DinnerCounts;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                FutureBuilder<MealChart>(
                  //통신데이터 가져오기
                  future: mealChart,
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
    getBreakfastCounts(snapshot);
    getLunchCounts(snapshot);
    getDinnerCounts(snapshot);


    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '2023 년',
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
                                '3 월',
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
                ),



                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      isPlaying ? randomData() : mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.topRight,
              /*
              child: IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  //color: AppColors.contentColorGreen,
                ),
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                    if (isPlaying) {
                      refreshState();
                    }
                  });
                },
              ),
              */
            ),
          )

        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color? barColor,
        double width = 22,
        List<int> showTooltips = const [],
      }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }


  List<BarChartGroupData> showingGroups() => List.generate(3, (i) {
      switch (i) {
        case 0:
          return makeGroupData(0, 18, isTouched: i == touchedIndex);
          //return makeGroupData(0, BreakfastCounts, isTouched: i == touchedIndex);
        case 1:
          return makeGroupData(1, 31, isTouched: i == touchedIndex);
          //return makeGroupData(1, LunchCounts, isTouched: i == touchedIndex);
        case 2:
          return makeGroupData(0, BreakfastCounts, isTouched: i == touchedIndex);
        default:
          return throw Error();
      }
  }
  );

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          //tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String meal;
            switch (group.x) {
              case 0:
                meal = '아침';
                break;
              case 1:
                meal = '점심';
                break;
              case 2:
                meal = '저녁';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$meal\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('아침', style: style);
        break;
      case 1:
        text = const Text('점심', style: style);
        break;
      case 2:
        text = const Text('저녁', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              //barColor: widget.availableColors[
              //Random().nextInt(widget.availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              //barColor: widget.availableColors[
              //Random().nextInt(widget.availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              //barColor: widget.availableColors[
              //Random().nextInt(widget.availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              //barColor: widget.availableColors[
              //Random().nextInt(widget.availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              //barColor: widget.availableColors[
              //Random().nextInt(widget.availableColors.length)],
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              //barColor: widget.availableColors[
              //Random().nextInt(widget.availableColors.length)],
            );
         case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
              //barColor: widget.availableColors[
              //Random().nextInt(widget.availableColors.length)],
            );
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}