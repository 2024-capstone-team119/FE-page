import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';

class DeadConcertCard extends StatefulWidget {
  const DeadConcertCard({Key? key}) : super(key: key);

  @override
  State<DeadConcertCard> createState() => _DeadConcertCardState();
}

class _DeadConcertCardState extends State<DeadConcertCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Performance>>(
      future: Api.getPerformanceApproaching(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('에러: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('데이터 없음');
        } else {
          List<Performance> performances = snapshot.data!;
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
      },
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
              onTap: () {},
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
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 12.0),
                              Text(
                                performance.name ?? '',
                                style: const TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3.0),
                              Text(
                                '${performance.startDate} ~ ${performance.endDate}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                '${performance.time}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${performance.place}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                '${performance.age}',
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
