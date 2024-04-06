import 'package:allcon/model/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlaceInfo extends StatefulWidget {
  final Place placeDetail;

  const PlaceInfo({super.key, required this.placeDetail});

  @override
  State<PlaceInfo> createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          PlaceBar(context, widget.placeDetail),
          const Divider(color: Colors.grey),
          const Text('지도 넣고 싶다.'),
        ],
      ),
    );
  }

  Widget PlaceBar(BuildContext context, Place placeDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeDetail.name!,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  placeDetail.adres!,
                  style: const TextStyle(fontSize: 12.0),
                ),
              ],
            ),
            initiallyExpanded: false,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.language_rounded,
                                  color: Colors.deepPurple, size: 15.0),
                              const SizedBox(width: 12.0),
                              Text(placeDetail.url!, // 프리즘홀 문제
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.call_rounded,
                                  color: Colors.deepPurple, size: 15.0),
                              const SizedBox(width: 12.0),
                              Text(placeDetail.tele!,
                                  style: const TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.directions_car_rounded,
                                  color: Colors.deepPurple, size: 15.0),
                              const SizedBox(width: 12.0),
                              Text(placeDetail == 'Y' ? '주차 공간 있음' : '주차 공간 없음',
                                  style: const TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Row(
                            children: [
                              const Icon(Icons.event_seat_rounded,
                                  color: Colors.deepPurple, size: 15.0),
                              const SizedBox(width: 12.0),
                              Text('최대 ${placeDetail.scale!}석',
                                  style: const TextStyle(fontSize: 12.0)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
