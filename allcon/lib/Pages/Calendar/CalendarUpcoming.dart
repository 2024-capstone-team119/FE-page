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
  late List<Performance> _performances = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Performance>>(
        future: Api.getPerformanceApproaching(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('데이터 없음');
          } else {
            _performances = snapshot.data!;
            final DateTime now = DateTime.now();
            final filteredSchedules =
                Map<DateTime, List<Performance>>.fromEntries(_performances
                    .where((performance) {
              DateTime startDate = DateTime.parse(performance.startDate!);
              return startDate.isAfter(now);
            }).map((performance) => MapEntry(
                        DateTime.parse(performance.startDate!),
                        [performance])));

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
                              final entry =
                                  filteredSchedules.entries.elementAt(index);
                              final eventDate = entry.key;
                              final eventList = entry.value;
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.84,
                                      child: Card(
                                        color: lavenderColor,
                                        elevation: 0.1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15.0, 15.0, 15.0, 0.0),
                                              child: Text(
                                                DateFormat.MMMd()
                                                    .format(eventDate),
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15.0, 4.0, 15.0, 4.0),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: eventList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final event =
                                                        eventList[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        print(
                                                            'Button tapped: ${event.name}');
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0.0,
                                                                    8.0,
                                                                    12.0,
                                                                    8.0),
                                                            child: Icon(
                                                              CupertinoIcons
                                                                  .music_mic,
                                                              size: 20.0,
                                                              color: Colors
                                                                  .deepPurple,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Text(
                                                                event.name ??
                                                                    '',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
        },
      ),
    );
  }
}
