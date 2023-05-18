import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:temp_project/const/colors.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:temp_project/MonthRecord.dart';

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }
  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }
  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }
  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}


final List<Meeting> meetings1 = <Meeting>[]; //지출 +-가 담긴 리스트
final List<Meeting> meetings2 = <Meeting>[]; //donation이 담긴 리스트
List<Meeting> _getDataSource() {
  return meetings1+meetings2;
}


class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Future<MonthRecord>? monthRecord;

  @override
  void initState() {
    super.initState();

    monthRecord = MonthRecordProvider().fetchMonthRecord();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                FutureBuilder<MonthRecord>(
                  //통신데이터 가져오기
                  future: monthRecord,
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
    String? showing_month_donation =snapshot.total_donate.toString();
    String? showing_total_saving = snapshot.month_saving.toString();
    print(showing_month_donation);
    print(showing_total_saving);


    /*
    String temp_day = "2023-05-01";
    int temp_int_year = int.parse(temp_day.substring(0, 4));
    int temp_int_month = int.parse(temp_day.substring(5, 7));
    int temp_int_date = int.parse(temp_day.substring(8, 10));
    int temp_differ = -8323;
    int temp_donation = 1000;
    if(temp_differ>=0){
      meetings1.add(Meeting(temp_differ.toString(),DateTime(temp_int_year,temp_int_month,temp_int_date),DateTime(temp_int_year,temp_int_month,temp_int_date),Colors.blue,false));
    }
    else{
      meetings1.add(Meeting(temp_differ.toString(),DateTime(temp_int_year,temp_int_month,temp_int_date),DateTime(temp_int_year,temp_int_month,temp_int_date),Colors.red,false));
    }
    meetings2.add( Meeting(temp_donation.toString(),DateTime(temp_int_year,temp_int_month,temp_int_date),DateTime(temp_int_year,temp_int_month,temp_int_date),PRIMARY_COLOR,false));


     */


    //snapshot.daily_record.length
    for(int i=0;i<snapshot.daily_record.length;i++){
      String temp_day = snapshot.daily_record[i].today_date;
      int temp_int_year = int.parse(temp_day.substring(0, 4));
      int temp_int_month = int.parse(temp_day.substring(5, 7));
      int temp_int_date = int.parse(temp_day.substring(8, 10));
      if(snapshot.daily_record[i].differ>=0){
        meetings1.add(Meeting(snapshot.daily_record[i].differ.toString(),DateTime(temp_int_year,temp_int_month,temp_int_date),DateTime(temp_int_year,temp_int_month,temp_int_date),Colors.blue,false));
      }
      else{
        meetings1.add(Meeting(snapshot.daily_record[i].differ.toString(),DateTime(temp_int_year,temp_int_month,temp_int_date),DateTime(temp_int_year,temp_int_month,temp_int_date),Colors.red,false));
      }
      meetings2.add( Meeting(snapshot.daily_record[i].donation.toString(),DateTime(temp_int_year,temp_int_month,temp_int_date),DateTime(temp_int_year,temp_int_month,temp_int_date),PRIMARY_COLOR,false));
    }



    //Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height*0.6, // 화면의 높이를 사용하여 컨테이너의 높이를 설정합니다.
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfCalendar(
            view: CalendarView.month,
            showNavigationArrow: true,
            dataSource: MeetingDataSource(_getDataSource()),
            monthViewSettings: MonthViewSettings(
              appointmentDisplayCount: 2,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              navigationDirection: MonthNavigationDirection.horizontal,
            ), //MonthViewSettings
          ), //SfCalendar
        ), //Padding
      ), //Container
    );//SingleChildScrollView
  }//buildList
}//_CalendarState
