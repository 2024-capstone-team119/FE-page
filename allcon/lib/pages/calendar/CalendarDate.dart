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
  final SelectedDayController _dayController =
      Get.find<SelectedDayController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectedDayController>(
      builder: (_) {
        final selectedDay = _dayController.selectedDay;
        return TableCalendar(
          locale: 'ko_KR',
          rowHeight: 68,
          availableGestures: AvailableGestures.none,
          firstDay: DateTime.utc(2021, 01, 01),
          lastDay: DateTime.utc(2025, 12, 31),
          focusedDay: selectedDay,
          onDaySelected: (selectedDay, focusedDay) {
            _dayController.setSelectedDay(selectedDay);
          },
          selectedDayPredicate: (day) => isSameDay(day, selectedDay),
          daysOfWeekHeight: 32,
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            headerPadding: EdgeInsets.symmetric(vertical: 4.0),
            leftChevronIcon: Icon(
              CupertinoIcons.chevron_left,
              size: 20.0,
            ),
            rightChevronIcon: Icon(
              CupertinoIcons.chevron_right,
              size: 20.0,
            ),
            leftChevronMargin: EdgeInsets.only(left: 90.0),
            rightChevronMargin: EdgeInsets.only(right: 90.0),
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
              fontWeight: FontWeight.w500,
            ),
            selectedDecoration: BoxDecoration(
              color: lightMint,
              shape: BoxShape.rectangle,
            ),
            outsideDaysVisible: false,
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
                      height: 16,
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
                  return const Center(child: Text('월'));
                case 2:
                  return const Center(child: Text('화'));
                case 3:
                  return const Center(child: Text('수'));
                case 4:
                  return const Center(child: Text('목'));
                case 5:
                  return const Center(child: Text('금'));
                case 6:
                  return const Center(
                      child:
                          Text('토', style: TextStyle(color: Colors.redAccent)));
                case 7:
                  return const Center(
                      child:
                          Text('일', style: TextStyle(color: Colors.redAccent)));
              }
              return null;
            },
          ),
          eventLoader: (day) => _dayController.getEventsForDay(day),
        );
      },
    );
  }
}
