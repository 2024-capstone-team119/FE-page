import 'package:flutter/material.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

class CalendarList extends StatefulWidget {
  const CalendarList({super.key});

  @override
  State<CalendarList> createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  late List<Performance> _performances = [];

  @override
  void initState() {
    super.initState();
    _fetchPerformances();
  }

  Future<void> _fetchPerformances() async {
    try {
      final List<Performance> performances = await Api.getPerformance();
      setState(() {
        _performances = performances;
      });
    } catch (error) {
      print('Error fetching performances: $error');
    }
  }

  List<Performance> _getEventsForDay(DateTime day) {
    return _performances.where((performance) {
      DateTime startDate = DateTime.parse(performance.startDate!);
      DateTime endDate = DateTime.parse(performance.endDate!);
      return startDate.isBefore(day) && endDate.isAfter(day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Performance> selectedDayEvents = _getEventsForDay(DateTime.now());

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          selectedDayEvents.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
                              performance.name ?? '', // 공연 이름 표시
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
