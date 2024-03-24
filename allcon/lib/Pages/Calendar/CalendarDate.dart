import 'package:flutter/material.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class CalendarDate extends StatefulWidget {
  const CalendarDate({super.key});

  @override
  State<CalendarDate> createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {
  DateTime _selectedDay = DateTime.now();
  late List<Performance> performances = [];

  // 선택한 날짜에 해당하는 공연 필터링
  List<Performance> _getEventsForDay(DateTime day) {
    return performances.where((performance) {
      DateTime startDate = DateTime.parse(performance.startDate!);
      DateTime endDate = DateTime.parse(performance.endDate!);
      return startDate.isBefore(day) && endDate.isAfter(day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Performance>>(
        future: Api.getPerformance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('데이터 없음');
          } else {
            performances = snapshot.data!;
            return TableCalendar(
              locale: 'ko_KR',
              firstDay: DateTime.utc(2021, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
              daysOfWeekHeight: 25,
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextFormatter: (date, locale) =>
                    DateFormat.yMMMM(locale).format(date),
                formatButtonVisible: false,
                titleTextStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
                headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
                leftChevronIcon: const Icon(
                  CupertinoIcons.chevron_left,
                  size: 20.0,
                ),
                rightChevronIcon: const Icon(
                  CupertinoIcons.chevron_right,
                  size: 20.0,
                ),
              ),
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                todayTextStyle: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.deepPurpleAccent.withOpacity(0.3),
                  shape: BoxShape.rectangle,
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
                selectedDecoration: BoxDecoration(
                  color: lavenderColor,
                  border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
                  shape: BoxShape.rectangle,
                ),
                outsideDaysVisible: false,
                weekendTextStyle: const TextStyle(color: Colors.grey),
                cellAlignment: Alignment.topCenter,
                tableBorder: const TableBorder(
                  horizontalInside: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.zero,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) => events.isNotEmpty
                    ? Positioned(
                        bottom: 3,
                        right: 3,
                        child: Container(
                          width: 18,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Text(
                            '${events.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      )
                    : null,
                dowBuilder: (context, date) {
                  switch (date.weekday) {
                    case 1:
                      return const Center(
                        child: Text('MON'),
                      );
                    case 2:
                      return const Center(
                        child: Text('TUE'),
                      );
                    case 3:
                      return const Center(
                        child: Text('WED'),
                      );
                    case 4:
                      return const Center(
                        child: Text('THU'),
                      );
                    case 5:
                      return const Center(
                        child: Text('FRI'),
                      );
                    case 6:
                      return const Center(
                        child: Text(
                          'SAT',
                        ),
                      );
                    case 7:
                      return const Center(
                        child: Text(
                          'SUN',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      );
                  }
                  return null;
                },
              ),
              eventLoader: (day) => _getEventsForDay(day),
            );
          }
        },
      ),
    );
  }
}
