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
              SizedBox(height: 65), // 수정된 부분
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
          backgroundColor: Colors.purple[50],
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '예매하기',
                style: TextStyle(
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
    return Stack(
      children: [
        Container(
            child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 235,
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
              height: 240,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  widget.performance.poster ?? "",
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.performance.name ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      softWrap: true,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      widget.performance.cast ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 15,
          child: IconButton(
            icon: Icon(
              isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: isFavorite ? Colors.redAccent : lightGray,
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
    );
  }

  Widget InfoDetailImg() {
    String imageUrl = widget.performance.imgs.toString() ?? "";
    imageUrl = imageUrl.replaceAll(RegExp(r'[\[\]]'), '');

    return Padding(
      padding: const EdgeInsets.all(12.5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // 높이 수정
        height: MediaQuery.of(context).size.height * 10,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
