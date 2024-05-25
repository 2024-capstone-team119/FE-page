import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/sub/ReviewTab.dart';
import 'package:allcon/pages/review/controller/hall_controller.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:allcon/service/review/hallService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewMain extends StatefulWidget {
  final String title;
  final String placeId;
  final int initialTab;

  const ReviewMain({
    super.key,
    required this.title,
    required this.placeId,
    this.initialTab = 0,
  });

  @override
  State<ReviewMain> createState() => _ReviewMainState();
}

class _ReviewMainState extends State<ReviewMain> {
  final HallController _hallController = Get.put(HallController());
  late Hall hall;
  String? loginUserId;
  String? loginUserNickname;

  _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginUserId = prefs.getString('userId');
      loginUserNickname = prefs.getString('userNickname');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  bool reviewWrite = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Hall?>(
        future: HallService.getHall(widget.placeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (!snapshot.hasData || snapshot.data == null) {
              hall = _hallController.bascirHall.value;
            } else {
              hall = snapshot.data!;
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  centerTitle: true,
                ),
                backgroundColor: const Color(0xFFF6F4F5),
                body: const Preparing(text: '이미지 준비중입니다 :)'),
              );
            } else {
              return GetBuilder<ReviewController>(
                init: ReviewController(),
                builder: (controller) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      centerTitle: true,
                    ),
                    backgroundColor: const Color(0xFFF6F4F5),
                    body: Stack(
                      children: [
                        Positioned(
                          bottom: 60.0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    'assets/img/lucky.png',
                                    width: 45,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '끝까지 내려주셨군요!\n이걸 본 당신은 올콘입니당 🍀 ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    'assets/img/lucky.png',
                                    width: 45,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: SnappingSheet(
                            snappingPositions: const [
                              SnappingPosition.factor(
                                positionFactor: 0.52,
                                snappingCurve: Curves.easeOutExpo,
                                snappingDuration: Duration(milliseconds: 500),
                                grabbingContentOffset:
                                    GrabbingContentOffset.top,
                              ),
                              SnappingPosition.factor(
                                positionFactor: 1.0,
                                snappingCurve: Curves.easeOutExpo,
                                snappingDuration: Duration(milliseconds: 500),
                                grabbingContentOffset:
                                    GrabbingContentOffset.top,
                              ),
                            ],
                            grabbing: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(45)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 45,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                            sheetBelow: SnappingSheetContent(
                              draggable: true,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(45),
                                  ),
                                ),
                                child: DefaultTabController(
                                  length: 3,
                                  initialIndex: widget.initialTab,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10.0),
                                      const TabBar(
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Colors.grey,
                                        indicatorColor: Colors.deepPurple,
                                        labelStyle: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500),
                                        unselectedLabelStyle:
                                            TextStyle(fontSize: 16.0),
                                        tabs: [
                                          Tab(text: '추천순'),
                                          Tab(text: '최신순'),
                                          Tab(text: '내 리뷰'),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            ReiviewTab(
                                              hall: hall,
                                              userId: loginUserId ?? '',
                                              userNickname:
                                                  loginUserNickname ?? '',
                                              mine: false,
                                              isRecommend: true,
                                            ),
                                            ReiviewTab(
                                              hall: hall,
                                              userId: loginUserId ?? '',
                                              userNickname:
                                                  loginUserNickname ?? '',
                                              mine: false,
                                              isRecommend: false,
                                            ),
                                            ReiviewTab(
                                              placeTitle: widget.title,
                                              placeId: widget.placeId,
                                              hall: hall,
                                              userId: loginUserId ?? '',
                                              userNickname:
                                                  loginUserNickname ?? '',
                                              mine: true,
                                              isRecommend: false,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8.0),
                                      child: Image.network(
                                        hall.hallImage ?? "",
                                        fit: BoxFit.cover,
                                        height: 360,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        });
  }
}
