import 'package:flutter/material.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:intl/intl.dart';

class PerformanceList extends StatelessWidget {
  final List<Performance> performances;

  const PerformanceList({super.key, required this.performances});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title(context),
        Divider(color: Colors.grey[300]),
        performances.isEmpty
            ? noPerformance(context)
            : listTab(context, performances),
      ],
    );
  }

  Widget title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '진행중/예정인 공연 (${performances.length})',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget noPerformance(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const Text(
              'O',
              style: TextStyle(
                fontSize: 120.0,
                fontFamily: 'Cafe24Moyamoya',
                color: Color(0xFFff66a1),
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              '진행 예정인 공연이 없습니다.', // text 수정
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }

  Widget startPerformance(int dDay, String startText) {
    if (dDay <= 0) {
      // 공연 중
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          startText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      // 공연 예정
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              startText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'D-${dDay + 1}',
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget listTab(BuildContext context, List<Performance> performances) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: performances.length,
      itemBuilder: (context, index) {
        DateTime startDate =
            DateFormat('yyyy.MM.dd').parse(performances[index].startDate!);
        DateTime now = DateTime.now();
        int dDay = startDate.difference(now).inDays;

        String startText = (dDay <= 0) ? '공연중' : '공연예정';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: SizedBox(
            height: 135,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    performances[index].poster!,
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: startPerformance(dDay, startText),
                      ),
                      Text(
                        performances[index].name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      if (performances[index].startDate ==
                          performances[index].endDate)
                        Text(
                          '${performances[index].startDate}',
                        )
                      else
                        Text(
                            '${performances[index].startDate} ~ ${performances[index].endDate}'),
                      Text(
                        '${performances[index].cast}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
