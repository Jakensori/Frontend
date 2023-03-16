import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:temp_project/const/colors.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class _CalendarState extends State<Calendar> {
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
              child: SfCalendar(
                view: CalendarView.month,
                dataSource: _getCalendarDataSource(),
                monthViewSettings: MonthViewSettings(
                    //showTrailingAndLeadingDates:true,
                    appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment,
                    navigationDirection: MonthNavigationDirection.horizontal
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

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];

    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(minutes: 10)),
      subject: '+1,500',
      color: PRIMARY_COLOR,
      startTimeZone: '',
      endTimeZone: '',
    ));

    return _AppointmentDataSource(appointments);
  }
}
