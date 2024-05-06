import 'package:allcon/Data/Sample/review_sample.dart';
import 'package:allcon/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HallController extends GetxController {
  HallController._internal();

  factory HallController() {
    return HallController._internal();
  }

  // 공연장 인덱스
  int getHallIdx(String hallName) {
    int index = seoulHall.indexWhere((hall) => hall.hallName == hallName);
    if (index != -1) {
      return seoulHall[index].hallIdx;
    } else {
      return -1;
    }
  }

  // 공연장 좌석배치도
  Widget getSeatingChartByHallName(String hallName) {
    Hall? hall = seoulHall.firstWhere(
      (hall) => hall.hallName == hallName,
    );

    return hall.seatingChart ?? Container();
  }

  // 공연장 구역 개수
  int getZoneLength(String hallName) {
    for (var hall in seoulHall) {
      if (hall.hallName == hallName) {
        return hall.zone.length;
      }
    }
    return -1;
  }

  // 공연장 구역 이름
  List<String> getZoneNames(String hallName) {
    var hall = seoulHall.firstWhere((hall) => hall.hallName == hallName);
    return hall.zone.map((zone) => zone.zoneName).toList();
  }
}
