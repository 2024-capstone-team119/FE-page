import 'package:allcon/pages/concerthall/HallSearch.dart';
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
                buildRow(context, ['서울', '경기•인천', '강원권']),
                buildRow(context, ['충청권', '경상권', '전라권']),
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
