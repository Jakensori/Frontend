import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:temp_project/const/colors.dart';
class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      color: BLACK_COLOR,
      fontWeight: FontWeight.w400,
    );


    return TableCalendar(
      focusedDay: focusedDay,
      firstDay:DateTime(1800),
      lastDay:DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
        ),
      ),

      calendarStyle: CalendarStyle(
        isTodayHighlighted : false,
        selectedDecoration: BoxDecoration(
          border: Border.all(
            color:PRIMARY_COLOR,
            width: 1.5,
          ),
        ),

        outsideDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),

        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle,
      ),

      onDaySelected: (DateTime selectedDay, DateTime focusedDay){
        setState((){
          this.selectedDay = selectedDay;
          this.focusedDay = selectedDay;
        });
      },

      selectedDayPredicate: (DateTime date){
        return date.year == selectedDay.year &&
        date.month == selectedDay.month &&
        date.day == selectedDay.day;
      },

    );
  }
}
