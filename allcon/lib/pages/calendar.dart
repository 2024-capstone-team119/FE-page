import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱 바 설정
      appBar: AppBar(
          // 앱 바의 타이틀 설정
          ),
      // 달력을 표시하는 TableCalendar 위젯을 body에 추가
      body: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2021, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        rowHeight: 80.0,

        // 추가
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextFormatter: (date, locale) =>
              DateFormat.yMMMM(locale).format(date),
          formatButtonVisible: false,
          titleTextStyle: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
          headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
          leftChevronIcon: const Icon(
            Icons.keyboard_arrow_left,
            size: 40.0,
          ),
          rightChevronIcon: const Icon(
            Icons.keyboard_arrow_right,
            size: 40.0,
          ),
        ),
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: true,
          todayTextStyle: TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 16.0,
          ),
          todayDecoration: BoxDecoration(
            color: Color(0xFF9FA8DA),
            shape: BoxShape.rectangle,
          ),
          outsideDaysVisible: false,
          weekendTextStyle: TextStyle(color: Colors.grey),
          cellAlignment: Alignment.topCenter,
          tableBorder: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.zero,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, date) {
            switch (date.weekday) {
              case 1:
                return const Center(
                  child: Text('Mon'),
                );
              case 2:
                return const Center(
                  child: Text('Tue'),
                );
              case 3:
                return const Center(
                  child: Text('Wed'),
                );
              case 4:
                return const Center(
                  child: Text('Thu'),
                );
              case 5:
                return const Center(
                  child: Text('Fri'),
                );
              case 6:
                return const Center(
                  child: Text('Sat'),
                );
              case 7:
                return const Center(
                  child: Text('Sun'),
                );
            }
            return null;
          },
        ),
      ),
    );
  }
}
