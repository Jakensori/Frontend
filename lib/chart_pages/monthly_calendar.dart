import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:temp_project/const/colors.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:temp_project/MonthRecord.dart';

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
    final List<Meeting> meetings1 = <Meeting>[];
    final List<Meeting> meetings2 = <Meeting>[];
    List<Meeting> _getDataSource() {return meetings1+meetings2;}

    String showing_month_donation =snapshot.total_donate.toString();
    String showing_total_saving = snapshot.month_saving.toString();


    
    for(int i=0;i<snapshot.daily_record.length;i++){
      String temp_day = snapshot.daily_record[i].today_date;
      int temp_int_year = int.parse(temp_day.substring(0,4));
      int temp_int_month = int.parse(temp_day.substring(5,7));
      int temp_int_date = int.parse(temp_day.substring(8,10));

      int temp_differ=snapshot.daily_record[i].differ;
      int temp_donation=snapshot.daily_record[i].donation;

      if(temp_differ>=0){
        meetings1.add(Meeting(temp_differ.toString(),DateTime(temp_int_year,temp_int_month,temp_int_date),DateTime(temp_int_year,temp_int_month,temp_int_date),Colors.blue,false));
      }
      else{
        meetings1.add(Meeting(temp_differ.toString(),DateTime(temp_int_year,temp_int_month,temp_int_date),DateTime(temp_int_year,temp_int_month,temp_int_date),Colors.red,false));
      }

      meetings2.add( Meeting(temp_donation.toString(),DateTime(temp_int_year,temp_int_month,temp_int_date),DateTime(temp_int_year,temp_int_month,temp_int_date),PRIMARY_COLOR,false));

      //List<Meeting> DailyData = _getTempDataSource();

    }


  //Widget build(BuildContext context){


    return MaterialApp(
      localizationsDelegates: [
        //GlobalMaterialLocalizations.delegate,
        //GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('ko'),
      ],
      locale: const Locale('ko'),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex:5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfCalendar(
                  view: CalendarView.month,
                  showNavigationArrow: true,
                  dataSource:  MeetingDataSource(_getDataSource()),
                  monthViewSettings: MonthViewSettings(
                    appointmentDisplayCount: 2,
                    appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment,
                    navigationDirection: MonthNavigationDirection.horizontal,

                  ),
                ),
              ),
            ),

            Expanded(
              flex:1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(100,10,30,10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('한 달 예산 대비 \n' + '한 달 기부 저금 \n'),
                    Text('$showing_total_saving원\n' + '$showing_month_donation원\n'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }//buildList
}
/*
List<Meeting> _getTempDataSource() {
  final int temp_year = 2023;
  final int temp_month = 3;
  final int temp_date = 1;
  final String temp_differ='600';
  final String temp_donation='0';
  var temp_int_differ=int.parse(temp_differ);


  final List<Meeting> meetings1 = <Meeting>[];
  if(temp_int_differ>=0){
    meetings1.add(Meeting(temp_differ,DateTime(temp_year,temp_month,temp_date),DateTime(temp_year,temp_month,temp_date),Colors.blue,false));
  }
  else{
    meetings1.add(Meeting(temp_differ,DateTime(temp_year,temp_month,temp_date),DateTime(temp_year,temp_month,temp_date),Colors.red,false));
  }



  final List<Meeting> meetings2 = <Meeting>[];
  meetings2.add( Meeting(temp_donation,DateTime(temp_year,temp_month,temp_date),DateTime(temp_year,temp_month,temp_date),PRIMARY_COLOR,false));

  return meetings1+meetings2;
}
*/
/*
class _SavedMoneyDataSource extends CalendarDataSource {
  _SavedMoneyDataSource(List<Appointment> source) {
    appointments = source;
  }
}

_SavedMoneyDataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];

  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(minutes: 10)),
    subject: '+1,500',
    color: PRIMARY_COLOR,
    startTimeZone: '',
    endTimeZone: '',
  ));

  return _SavedMoneyDataSource(appointments);
}
 */



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

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

}