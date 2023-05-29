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

class CustomCalendarHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 헤더의 컨테이너를 커스텀하여 원하는 스타일과 레이아웃을 적용할 수 있습니다.
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Custom Header',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


List<Meeting> meetings1 = <Meeting>[]; //지출 +-가 담긴 리스트
List<Meeting> meetings2 = <Meeting>[]; //donation이 담긴 리스트
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
  final int currentYear = DateTime.now().year;
  final int currentMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedSaving = 0;
  int selectedDonation = 0;
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    monthRecord = MonthRecordProvider().fetchMonthRecord(currentYear, currentMonth);
  }

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      locale: const Locale('ko'),
      supportedLocales: const [
        Locale('ko'), // 한국어
      ],
      localizationsDelegates: [
        SfGlobalLocalizations.delegate,
      ],
      //debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          )),
    );
  }


  Widget buildList(snapshot) {
    meetings1 = [];
    meetings2 = [];
    selectedSaving=snapshot.month_saving;
    selectedDonation=snapshot.month_donation;
    String? showing_month_saving = selectedSaving.toString();
    String? showing_month_donation=selectedDonation.toString();

    //String? showing_month_donation =snapshot.total_donate.toString();
    //String? showing_total_saving = snapshot.month_saving.toString();

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
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.6, // 화면의 높이를 사용하여 컨테이너의 높이를 설정합니다.
            width: MediaQuery.of(context).size.width*0.95,
              child: SfCalendar(
                view: CalendarView.month,
                controller: _calendarController,
                onViewChanged:(ViewChangedDetails details){
                  final DateTime visibleDate = details.visibleDates[15];
                  selectedMonth= visibleDate.month;
                  selectedYear = visibleDate.year;
                  print('get재호출');
                  monthRecord = MonthRecordProvider().fetchMonthRecord(selectedYear,selectedMonth);

                  // selectedSaving=monthRecord.month_saving;
                  // print(selectedSaving);
                  //
                  print(showing_month_saving);
                  print(showing_month_donation);
                },
                showNavigationArrow: false,
                dataSource: MeetingDataSource(_getDataSource()),
                monthViewSettings: MonthViewSettings(
                  appointmentDisplayCount: 2,
                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                  navigationDirection: MonthNavigationDirection.horizontal,
                ), //MonthViewSettings
              ), //SfCalendar
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.1, // 화면의 높이를 사용하여 컨테이너의 높이를 설정합니다.
              width: MediaQuery.of(context).size.width*0.9,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('\n\n한 달 예산 대비    \n'+'한 달 기부 저금    \n'),
                  Text('\n\n$showing_month_saving 원\n' + '$showing_month_donation 원\n')
                ],
              )
            ),
          )
        ],
      ), //Container
    );
  }//buildList
}//_CalendarState
