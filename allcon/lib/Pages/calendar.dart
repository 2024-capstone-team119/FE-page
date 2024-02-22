import 'dart:collection';
import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Event {
  String title;
  Event(this.title);

  @override
  String toString() => title;
}

Map<DateTime, dynamic> eventSource = {
  DateTime(2024, 1, 18): [
    Event('김늑'),
    Event('블루파프리카'),
  ],
  DateTime(2024, 1, 26): [
    Event('손예지'),
  ],
  DateTime(2024, 1, 27): [
    Event('10CM'),
    Event('나상현씨밴드'),
    Event('마이 앤트 메리'),
    Event('오월오일'),
    Event('웨스턴카잇'),
    Event('헤이맨'),
  ],
};

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap(
    equals: isSameDay,
  )..addAll(eventSource.cast<DateTime, List<Event>>());

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? []; // 이벤트가 없으면 빈 리스트 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: "달력"),
      // 달력을 표시하는 TableCalendar 위젯을 body에 추가
      body: Padding(
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
                eventLoader: (day) => _getEventsForDay(day),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              // Upcoming 이벤트를 표시하는 ListView 추가
              ListView.builder(
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final eventDate = events.keys.elementAt(index);
                  final eventList = events[eventDate] as List<Event>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              DateFormat.MMMd().format(eventDate),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.grey,
                            size: 40.0,
                          ),
                        ],
                      ),
                      Column(
                        children: eventList.map((event) {
                          return ListTile(
                            title: Text(event.title),
                          );
                        }).toList(),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
