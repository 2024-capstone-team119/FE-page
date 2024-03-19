import 'package:allcon/Pages/ConcertHall/hall_search.dart';
import 'package:flutter/material.dart';

class ConcertHallTable extends StatelessWidget {
  const ConcertHallTable({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orangeAccent,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // const Padding(
          //   padding: EdgeInsets.only(
          //     right: 20.0,
          //     left: 20.0,
          //   ),
          //   // child: Text(
          //   //   '공연장',
          //   //   style: TextStyle(
          //   //     fontWeight: FontWeight.w600,
          //   //     fontSize: 24.0,
          //   //     color: Colors.black,
          //   //   ),
          //   // ),
          // ),
          // const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
              top: 5.0,
            ),
            child: Table(
              border: TableBorder.all(),
              children: [
                buildRow(context, ['서울', '경기도/인천', '강원도']),
                buildRow(context, ['충청도', '경상도', '전라도']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow buildRow(BuildContext context, List<String> cells) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.white),
      children: cells
          .map(
            (cell) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HallSearch(
                      initialTitle: cell,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      cell,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
