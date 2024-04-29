import 'package:flutter/material.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'controller/selecetedDay_controller.dart';

class CalendarDate extends StatefulWidget {
  const CalendarDate({super.key});
  @override
  State<CalendarDate> createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {
  final SelectedDayController controller = Get.put(SelectedDayController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          calendarDate(context),
          GetBuilder<SelectedDayController>(
            builder: (_) => calendarList(context),
          ),
        ],
      ),
    );
  }

  Widget calendarDate(BuildContext context) {
    return GetBuilder<SelectedDayController>(
      builder: (_) {
        final selectedDay = controller.selectedDay;
        return TableCalendar(
          locale: 'ko_KR',
          firstDay: DateTime.utc(2021, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: selectedDay,
          onDaySelected: (selectedDay, focusedDay) {
            controller.setSelectedDay(selectedDay);
            setState(() {});
          },
          selectedDayPredicate: (day) => isSameDay(day, selectedDay),
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
            leftChevronMargin: const EdgeInsets.only(left: 90.0),
            rightChevronMargin: const EdgeInsets.only(right: 90.0),
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
                      width: 80,
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
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
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
          eventLoader: (day) => controller.getEventsForDay(day),
        );
      },
    );
  }

  Widget calendarList(BuildContext context) {
    final selectedDayEvents =
        controller.getEventsForDay(controller.selectedDay);
    return selectedDayEvents.isEmpty
        ? const SizedBox.shrink()
        : Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Row(
                children: [
                  const SizedBox(width: 5.0),
                  Text(
                    DateFormat('yyyy.MM.dd').format(controller.selectedDay),
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