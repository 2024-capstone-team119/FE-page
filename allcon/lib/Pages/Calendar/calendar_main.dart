import 'dart:collection';
import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:allcon/Pages/Calendar/calendar_schedule.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final LinkedHashMap<DateTime, List<Schedule>> schedules = LinkedHashMap(
    equals: isSameDay,
  )..addAll(scheduleList.cast<DateTime, List<Schedule>>());

  List<Schedule> _getEventsForDay(DateTime day) {
    return schedules[day] ?? []; // 이벤트가 없으면 빈 리스트 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "달력",
      ),
      // 달력을 표시하는 TableCalendar 위젯을 body에 추가
      body: calendar(context),
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
    );
  }

  Widget calendar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: 'ko_KR',
              firstDay: DateTime.utc(2021, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              rowHeight: 80.0,
              daysOfWeekHeight: 30,
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextFormatter: (date, locale) =>
                    DateFormat.yMMMM(locale).format(date),
                formatButtonVisible: false,
                titleTextStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
                leftChevronIcon: const Icon(
                  Icons.keyboard_arrow_left,
                  size: 30.0,
                ),
                rightChevronIcon: const Icon(
                  Icons.keyboard_arrow_right,
                  size: 30.0,
                ),
              ),
              calendarStyle: const CalendarStyle(
                isTodayHighlighted: true,
                todayTextStyle: TextStyle(
                  color: Colors.white,
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
                        child: Text(
                          'Sat',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      );
                    case 7:
                      return const Center(
                        child: Text(
                          'Sun',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      );
                  }
                  return null;
                },
              ),
              eventLoader: (day) => _getEventsForDay(day),
            ),
            const SizedBox(
              height: 30.0,
            ),
            upcoming(context),
          ],
        ),
      ),
    );
  }

  Widget upcoming(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime endOfWeek = now.add(const Duration(days: 7));
    final filteredSchedules = schedules.entries.where(
        (entry) => entry.key.isAfter(now) && entry.key.isBefore(endOfWeek));
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Text(
                "Upcoming",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: filteredSchedules.length,
            itemBuilder: (context, index) {
              final eventDate = filteredSchedules.elementAt(index).key;
              final eventList = filteredSchedules.elementAt(index).value;
              return SizedBox(
                width: 300,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                        child: Text(
                          DateFormat.MMMd().format(eventDate),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 4.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: eventList.length,
                            itemBuilder: (context, index) {
                              final event = eventList[index];
                              return InkWell(
                                onTap: () {
                                  print('Button tapped: ${event.title}');
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 8.0, 15.0, 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.deepPurple,
                                        ),
                                        width: 5.0,
                                        height: 40.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          event.title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          ),
                                          overflow: TextOverflow
                                              .ellipsis, // 텍스트가 너무 길 경우 자동으로 줄바꿈되도록 설정
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
