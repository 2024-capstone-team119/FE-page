import 'package:allcon/Util/Theme.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/Pages/Concert/PerformaceDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeadConcertCard extends StatefulWidget {
  final List<Performance> performances;

  const DeadConcertCard({Key? key, required this.performances});

  @override
  State<DeadConcertCard> createState() => _DeadConcertCardState();
}

class _DeadConcertCardState extends State<DeadConcertCard> {
  @override
  Widget build(BuildContext context) {
    List<Performance> performances = widget.performances;
    List<Performance> firstList = performances.sublist(0, 3);
    List<Performance> secondList = performances.sublist(3, 6);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          _buildPerformanceList(context, firstList),
          const SizedBox(width: 5.0),
          _buildPerformanceList(context, secondList),
          const SizedBox(width: 15.0),
        ],
      ),
    );
  }

  Widget _buildPerformanceList(
      BuildContext context, List<Performance> performances) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(performances.length, (index) {
          Performance performance = performances[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => PerformanceDetail(performance: performance));
              },
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black26, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.78,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                        child: Image.network(
                          performance.poster ?? '',
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 12.0),
                              Text(
                                performance.name ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              if (performance.cast != null &&
                                  performance.cast != null &&
                                  performance.cast!.trim().isNotEmpty)
                                Text(
                                  '${performance.cast}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (performance.startDate == performance.endDate)
                                Text(
                                  '${performance.startDate}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                )
                              else
                                Text(
                                  '${performance.startDate} ~ ${performance.endDate}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              Text(
                                '${performance.place}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
