import 'package:flutter/material.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class CalendarDate extends StatefulWidget {
  final List<Performance> performances;

  const CalendarDate({super.key, required this.performances});
  @override
  State<CalendarDate> createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {
  late DateTime _selectedDay = DateTime.now();
  late List<Performance> performances = [];
  late Map<DateTime, List<Performance>> _eventsMap = {};

  @override
  void initState() {
    super.initState();
    _calculateEventsMap();
  }

  void _calculateEventsMap() {
    _eventsMap = {};
    for (var performance in widget.performances) {
      DateTime startDate =
          DateFormat("yyyy.MM.dd").parse(performance.startDate!);
      DateTime endDate = DateFormat("yyyy.MM.dd").parse(performance.endDate!);
      for (var date = startDate;
          date.isBefore(endDate.add(const Duration(days: 1)));
          date = date.add(const Duration(days: 1))) {
        _eventsMap.update(date, (value) => value + [performance],
            ifAbsent: () => [performance]);
      }
    }
    // DateTime today = DateTime.now();
    // List<Performance>? eventsForToday = _eventsMap[today];
    // int eventsForTodayLength = eventsForToday?.length ?? 0;
    // print('Events for today ($_selectedDay): $eventsForTodayLength');
  }

  @override
  Widget build(BuildContext context) {
    List<Performance> getEventsForDay(DateTime day) {
      return widget.performances.where((performance) {
        DateTime startDate =
            DateFormat("yyyy.MM.dd").parse(performance.startDate!);
        DateTime endDate = DateFormat("yyyy.MM.dd").parse(performance.endDate!);
        return (startDate.isBefore(day) || startDate.isAtSameMomentAs(day)) &&
            (endDate.isAfter(day) || endDate.isAtSameMomentAs(day));
      }).toList();
    }

    // List<Performance> events = getEventsForDay(DateTime.now());
    // print('Events for today: ${events.length}');

    return SingleChildScrollView(
      child: Column(
        children: [
          calendarDate(context),
          calendarList(context, getEventsForDay(_selectedDay)),
        ],
      ),
    );
  }

  Widget calendarDate(BuildContext context) {
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
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: true,
        todayTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.rectangle,
        ),
        selectedTextStyle: TextStyle(
            color: lightlavenderColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w500),
        selectedDecoration: BoxDecoration(
          color: lightMint,
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
        weekendTextStyle: TextStyle(color: Colors.grey),
        cellAlignment: Alignment.topCenter,
        tableBorder: TableBorder(
          horizontalInside: BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.zero,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) => events.isNotEmpty
            ? Positioned(
                bottom: 0,
                child: Container(
                  width: 65,
                  height: 15,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: lavenderColor,
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                  child: Text(
                    '${events.length}',
                    style: const TextStyle(
                      color: Colors.deepPurple,
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
      eventLoader: (day) => _eventsMap[day] ?? [],
    );
  }

  Widget calendarList(
      BuildContext context, List<Performance> selectedDayEvents) {
    return selectedDayEvents.isEmpty
        ? const SizedBox.shrink()
        : Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Row(
                children: [
                  const SizedBox(width: 5.0),
                  Text(
                    DateFormat('yyyy.MM.dd').format(_selectedDay),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              initiallyExpanded: false,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedDayEvents.map((performance) {
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
                              performance.name ?? '',
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
            ),
          );
  }
}
