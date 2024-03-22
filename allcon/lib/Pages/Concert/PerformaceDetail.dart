import 'dart:ui';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:allcon/Data/Concert.dart';
import 'package:flutter/cupertino.dart';
import 'package:allcon/model/performance_model.dart';

class PerformanceDetail extends StatefulWidget {
  final Performance performance;

  const PerformanceDetail({Key? key, required this.performance})
      : super(key: key);

  @override
  State<PerformanceDetail> createState() => _PerformanceDetailState();
}

class _PerformanceDetailState extends State<PerformanceDetail> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "상세 정보",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InfoHeader(context),
              InfoDetailImg(),
              SizedBox(height: 70), // 수정된 부분
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.88,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            // 예매처 이동
          },
          backgroundColor: Mint,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '예매하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }

  Widget InfoHeader(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                    child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.performance.poster ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                )
              ],
            ),
            Positioned(
              bottom: 10,
              left: 25,
              child: Expanded(
                child: Image.network(
                  widget.performance.poster ?? "",
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 186,
              right: 15,
              child: IconButton(
                icon: Icon(
                  isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  color: isFavorite ? Colors.redAccent : Colors.black26,
                  size: 30.0,
                ),
                color: Colors.redAccent,
                onPressed: () {
                  // 버튼 클릭 시 수행할 작업
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.performance.name ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                softWrap: true,
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    widget.performance.genre ?? "",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.performance.area ?? "",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.performance.age ?? "",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(CupertinoIcons.music_mic, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.performance.cast ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Icon(CupertinoIcons.placemark, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.performance.place ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Icon(CupertinoIcons.calendar, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${widget.performance.startDate} ~ ${widget.performance.endDate}' ??
                          'Unknown',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget InfoDetailImg() {
    String imageUrl = widget.performance.imgs.toString() ?? "";
    imageUrl = imageUrl.replaceAll(RegExp(r'[\[\]]'), '');

    return imageUrl.isEmpty || imageUrl == "null"
        ? Container()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  decoration: BoxDecoration(
                    color: lightGray,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      '공연정보',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
  }
}
