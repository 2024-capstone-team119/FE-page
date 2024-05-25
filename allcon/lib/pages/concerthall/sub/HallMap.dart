import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class HallMap extends StatelessWidget {
  final double longitude; // 경도
  final double latitude; // 위도

  const HallMap({
    super.key,
    required this.longitude,
    required this.latitude,
  });

  @override
  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();

    final cameraPosition = NCameraPosition(
      target: NLatLng(latitude, longitude),
      zoom: 15.5,
      bearing: 45,
      tilt: 0,
    );

    return Scaffold(
      body: NaverMap(
        options: NaverMapViewOptions(
          initialCameraPosition: cameraPosition, // 카메라 초기 위치
          indoorEnable: true, // 실내 맵 사용 가능 여부 설정
          locationButtonEnable: false, // 위치 버튼 표시 여부 설정
          consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
        ),
        onMapReady: (controller) async {
          // 공연장 위치 표시
          final marker = NMarker(
            id: '1',
            position: NLatLng(latitude, longitude),
          );

          controller.addOverlay(marker);

          // 지도 준비 완료 시 호출되는 콜백 함수
          mapControllerCompleter
              .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
        },
      ),
    );
  }
}
