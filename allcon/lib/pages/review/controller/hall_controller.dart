import 'package:allcon/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HallController extends GetxController {
  HallController._internal();

  factory HallController() {
    return HallController._internal();
  }

  // 공연장 인덱스
  int getHallIdx(String hallName, List<Hall> hallList) {
    int index = hallList.indexWhere((hall) => hall.hallName == hallName);
    if (index != -1) {
      return hallList[index].hallIdx;
    } else {
      Hall? plannedHall = hallList.firstWhere((hall) => hall.hallName == '예정');
      return plannedHall.hallIdx;
    }
  }

  // 공연장 좌석배치도
  Widget getSeatingChartByHallName(String hallName, List<Hall> hallList) {
    Hall? hall = hallList.firstWhere(
      (hall) => hall.hallName == hallName,
      orElse: () => hallList.firstWhere((hall) => hall.hallName == '예정'),
    );
    print(hall.hallName);
    return hall.seatingChart!;
  }

  // 공연장 구역 개수
  int getZoneLength(String hallName, List<Hall> hallList) {
    for (var hall in hallList) {
      if (hall.hallName == hallName) {
        return hall.zone.length;
      } else {
        Hall? plannedHall =
            hallList.firstWhere((hall) => hall.hallName == '예정');
        return plannedHall.zone.length;
      }
    }
    return -1;
  }

  // 공연장 구역 이름
  List<String> getZoneNames(String hallName, List<Hall> hallList) {
    Hall hall =
        hallList.firstWhere((hall) => hall.hallName == hallName, orElse: () {
      return hallList.firstWhere((hall) => hall.hallName == '예정');
    });
    return hall.zone.map((zone) => zone.zoneName).toList();
  }
}
