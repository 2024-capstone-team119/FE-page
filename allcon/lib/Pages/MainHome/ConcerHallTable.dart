import 'package:allcon/Pages/ConcertHall/HallList.dart';
import 'package:allcon/Pages/ConcertHall/HallSearch.dart';
import 'package:flutter/material.dart';

class ConcertHallTable extends StatelessWidget {
  const ConcertHallTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
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
      decoration: const BoxDecoration(color: Colors.white),
      children: cells
          .map(
            (cell) => InkWell(
              onTap: () {
                handleCellTap(context, cell);
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

  void handleCellTap(BuildContext context, String cell) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HallSearch(area: cell),
      ),
    );
  }
}
