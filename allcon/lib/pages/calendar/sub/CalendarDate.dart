import 'package:allcon/pages/calendar/controller/selecetedDay_controller.dart';
import 'package:flutter/material.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class CalendarDate extends StatefulWidget {
  const CalendarDate({super.key});
  @override
  State<CalendarDate> createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {
  final SelectedDayController _dayController =
      Get.find<SelectedDayController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectedDayController>(builder: (_) {
      final selectedDay = _dayController.selectedDay;
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: TableCalendar(
          availableGestures: AvailableGestures.none,
          focusedDay: selectedDay,
          firstDay: DateTime.utc(2024, 01, 01),
          lastDay: DateTime.utc(2024, 12, 31),
          rowHeight: 64,
          onDaySelected: (selectedDay, focusedDay) {
            _dayController.setSelectedDay(selectedDay);
            _dayController.fetchPerformancesByDate(selectedDay);
          },
          selectedDayPredicate: (day) => isSameDay(day, selectedDay),
          daysOfWeekHeight: 36,
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextFormatter: (date, locale) =>
                DateFormat.yMMMM(locale).format(date),
            formatButtonVisible: false,
            titleTextStyle: const TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
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
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, date) {
              switch (date.weekday) {
                case 1:
                  return const Center(
                    child: Text(
                      '월',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                case 2:
                  return const Center(
                    child: Text(
                      '화',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                case 3:
                  return const Center(
                    child: Text(
                      '수',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                case 4:
                  return const Center(
                    child: Text(
                      '목',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                case 5:
                  return const Center(
                    child: Text(
                      '금',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                case 6:
                  return const Center(
                    child: Text(
                      '토',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                case 7:
                  return const Center(
                    child: Text(
                      '일',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
              }
              return null;
            },
          ),
          calendarStyle: const CalendarStyle(
            todayTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(
              color: lightlavenderColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            selectedDecoration: BoxDecoration(
              color: lightMint,
              shape: BoxShape.circle,
            ),
            defaultTextStyle: TextStyle(
              fontSize: 16.0,
            ),
            outsideDaysVisible: false,
            weekendTextStyle: TextStyle(color: Colors.grey),
            cellAlignment: Alignment.center,
            tableBorder: TableBorder(
              horizontalInside: BorderSide(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      );
    });
  }
}
