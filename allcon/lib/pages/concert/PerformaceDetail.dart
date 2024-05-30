import 'dart:ui';
import 'package:allcon/pages/concerthall/HallMain.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:allcon/service/concertLikesService.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:allcon/pages/concert/PerformaceDetail.dart';

class PerformanceDetail extends StatefulWidget {
  final Performance performance;

  const PerformanceDetail({super.key, required this.performance});

  @override
  State<PerformanceDetail> createState() => _PerformanceDetailState();
}

class _PerformanceDetailState extends State<PerformanceDetail> {
  String? loginUserId;
  String? loginUserNickname;

  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserId = prefs.getString('userId');
    loginUserNickname = prefs.getString('userNickname');

    if (loginUserId != null) {
      _checkFavoriteStatus(loginUserId!, widget.performance.mid.toString());
    }
  }

  Future<void> _checkFavoriteStatus(String userId, String performanceId) async {
    bool favorited =
        await ConcertLikesService.isFavorited(userId, performanceId);
    setState(() {
      isFavorited = favorited;
    });
  }

  Future<void> _toggleFavorite() async {
    var result = await ConcertLikesService.toggleFavorite(
      loginUserId.toString(),
      widget.performance.mid.toString(),
    );

    if (result['favorited'] != null) {
      setState(() {
        isFavorited = result['favorited'];
      });
    }
  }

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
              InfoDetailImgs(),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.performance.relates != null &&
              widget.performance.relates!.isNotEmpty
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  launchURL(widget.performance.relates!.first.url);
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
            )
          : null,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                )
              ],
            ),
            Positioned(
              bottom: 10,
              left: 25,
              child: Image.network(
                widget.performance.poster ?? "",
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 186,
              right: 15,
              child: IconButton(
                icon: Icon(
                  isFavorited
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: isFavorited ? Colors.redAccent : Colors.black26,
                  size: 30.0,
                ),
                onPressed: _toggleFavorite,
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
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    widget.performance.genre ?? "",
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.performance.area ?? "",
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.performance.age ?? "",
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              if (widget.performance.cast != null &&
                  widget.performance.cast!.trim().isNotEmpty)
                Row(
                  children: [
                    const Icon(CupertinoIcons.music_mic, size: 18),
                    const SizedBox(width: 8),
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
              const SizedBox(height: 3),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HallMain(
                        title: widget.performance.place ?? 'Unknown',
                        id: widget.performance.placeId ?? 'Unknown',
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.placemark, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.performance.place ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.deepPurple,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.deepPurple,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(CupertinoIcons.calendar, size: 18),
                  const SizedBox(width: 8),
                  if (widget.performance.startDate ==
                      widget.performance.endDate)
                    Expanded(
                      child: Text(
                        '${widget.performance.startDate}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        softWrap: true,
                      ),
                    )
                  else
                    Expanded(
                      child: Text(
                        '${widget.performance.startDate} ~ ${widget.performance.endDate}',
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

  Widget InfoDetailImgs() {
    List<String>? imgUrls = widget.performance.imgs;
    String poster = widget.performance.poster.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Center(
              child: Text(
                '공연정보',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        if (imgUrls == null || imgUrls.isEmpty)
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.network(
              poster,
              fit: BoxFit.contain,
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: imgUrls.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Image.network(
                  imgUrls[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
      ],
    );
  }
}
