import 'package:flutter/material.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class CalendarUpcoming extends StatefulWidget {
  const CalendarUpcoming({super.key});

  @override
  State<CalendarUpcoming> createState() => _CalendarUpcomingState();
}

class _CalendarUpcomingState extends State<CalendarUpcoming> {
  late List<Performance> performances = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Performance>>(
      future: Api.getPerformanceApproaching(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return Text('에러: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('데이터 없음');
        } else {
          List<Performance> performances = snapshot.data!;
          return buildUpcomingPerformances(performances);
        }
      },
    );
  }

  Widget buildUpcomingPerformances(List<Performance> performances) {
    Map<DateTime, List<Performance>> groupedPerformances = {};
    for (var performance in performances) {
      DateTime startDate =
          DateFormat("yyyy.MM.dd").parse(performance.startDate!);
      groupedPerformances.putIfAbsent(startDate, () => []);
      groupedPerformances[startDate]!.add(performance);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12.0),
          const Row(
            children: [
              Text(
                "UPCOMING",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                'O',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 30.0,
                  fontFamily: 'Cafe24Moyamoya',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: groupedPerformances.length,
              itemBuilder: (context, index) {
                final List<Performance> events =
                    groupedPerformances.values.toList()[index];
                return buildPerformanceCard(events);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPerformanceCard(List<Performance> events) {
    events.sort((a, b) => a.startDate!.compareTo(b.startDate!));
    return Padding(
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
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                child: Text(
                  DateFormat.MMMd().format(
                      DateFormat("yyyy.MM.dd").parse(events.first.startDate!)),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Divider(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 4.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: events.map((event) {
                        return InkWell(
                          onTap: () {
                            print('Button tapped: ${event.name}');
                          },
                          child: Row(
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 8.0),
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
                                    event.name ?? '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
