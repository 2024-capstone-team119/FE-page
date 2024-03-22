import 'dart:collection';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:allcon/Pages/Calendar/calendar_schedule.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            calendar(context),
            const SizedBox(height: 16.0),
            eventList(context),
            const SizedBox(height: 28.0),
            upcoming(context),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
    );
  }

  Widget calendar(BuildContext context) {
    List<Schedule> selectedDayEvents = _getEventsForDay(_selectedDay);

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
            fontSize: 18.0, color: Colors.black87, fontWeight: FontWeight.w500),
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
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
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

  Widget eventList(BuildContext context) {
    List<Schedule> selectedDayEvents = _getEventsForDay(_selectedDay);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        selectedDayEvents.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectedDayEvents.map((event) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        color: lavenderColor,
                        border: Border.all(
                            color: Colors.deepPurple.withOpacity(0.05)),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
      ],
    );
  }

  Widget upcoming(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime endOfWeek = now.add(const Duration(days: 7));
    final filteredSchedules = schedules.entries.where(
        (entry) => entry.key.isAfter(now) && entry.key.isBefore(endOfWeek));
    return filteredSchedules.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 12.0),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            "UPCOMING",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 3.0),
                          Text(
                            'O',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 30.0,
                              fontFamily: 'Cafe24Moyamoya',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredSchedules.length,
                    itemBuilder: (context, index) {
                      final eventDate = filteredSchedules.elementAt(index).key;
                      final eventList =
                          filteredSchedules.elementAt(index).value;
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.84,
                              child: Card(
                                color: lavenderColor,
                                elevation: 0.1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15.0, 15.0, 15.0, 0.0),
                                      child: Text(
                                        DateFormat.MMMd().format(eventDate),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          8.0, 0.0, 8.0, 0.0),
                                      child: Divider(),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15.0, 4.0, 15.0, 4.0),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: eventList.length,
                                          itemBuilder: (context, index) {
                                            final event = eventList[index];
                                            return InkWell(
                                              onTap: () {
                                                print(
                                                    'Button tapped: ${event.title}');
                                              },
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets
                                                        .fromLTRB(
                                                        0.0, 8.0, 12.0, 8.0),
                                                    child: Icon(
                                                      CupertinoIcons.music_mic,
                                                      size: 20.0,
                                                      color: Colors.deepPurple,
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
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 36.0),
              ],
            ),
          );
  }
}
