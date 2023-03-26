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
  Future<MealChart>? monthRecord;

  @override
  void initState() {
    super.initState();
    monthRecord = MonthRecordProvider().fetchMonthRecord();
  }

  @override
  Widget build(BuildContext context) {
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
                      appointmentDisplayCount: 3,
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
                    Text('-12,500원\n' + '+6,200원\n'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
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

List<Meeting> _getDataSource() {
  final List<Meeting> meetings1 = <Meeting>[
    Meeting('saved money',DateTime(2023,3,1),DateTime(2023,3,1),Colors.blue,false),
  ];

  final List<Meeting> meetings2 = <Meeting>[
    Meeting('donated money',DateTime(2023,3,1),DateTime(2023,3,1),PRIMARY_COLOR,false),
  ];

  final DateTime today = DateTime.now();
  //final DateTime startTime =
  //DateTime(today.year, today.month, today.day, 9, 0, 0);
  //final DateTime endTime = startTime.add(const Duration(hours: 2));
  return meetings1+meetings2;
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

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

}