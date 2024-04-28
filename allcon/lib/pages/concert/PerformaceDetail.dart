import 'dart:ui';
import 'package:allcon/model/concertLikes_model.dart';
import 'package:allcon/service/concertLikesService.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:http/http.dart' as http;

class PerformanceDetail extends StatefulWidget {
  final Performance performance;

  const PerformanceDetail({super.key, required this.performance});

  @override
  State<PerformanceDetail> createState() => _PerformanceDetailState();
}

class _PerformanceDetailState extends State<PerformanceDetail> {
  bool isMyLikesConcert = false;
  ConcertLikes? concertLikes;
  final client = http.Client();

  @override
  void initState() {
    super.initState();
    fetchConcertLikesData();
  }

  Future<void> fetchConcertLikesData() async {
    concertLikes =
        await ConcertLikesService().fetchConcertLikes(client, 'userId');
    setState(() {
      isMyLikesConcert =
          concertLikes?.concertId.contains(widget.performance.id) ?? false;
    });
  }

  Future<void> updateConcertLikesData() async {
    // async 추가
    if (concertLikes == null) {
      concertLikes = ConcertLikes('', 'userId', []);
    }
    final updatedConcertIds = isMyLikesConcert
        ? [...concertLikes!.concertId, widget.performance.id]
        : concertLikes!.concertId
            .where((id) => id != widget.performance.id)
            .toList();
    concertLikes = ConcertLikes(concertLikes!.id, concertLikes!.userId,
        updatedConcertIds.cast<String>());
    await ConcertLikesService().updateConcertLikes(client, concertLikes!);
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
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
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
                SizedBox(
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
                  isMyLikesConcert
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: isMyLikesConcert ? Colors.redAccent : Colors.black26,
                  size: 30.0,
                ),
                color: Colors.redAccent,
                onPressed: () async {
                  // 버튼 클릭 시 수행할 작업
                  setState(() {
                    isMyLikesConcert = !isMyLikesConcert;
                  });
                  await updateConcertLikesData();
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
              // 수정하기
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
              Row(
                children: [
                  const Icon(CupertinoIcons.placemark, size: 18),
                  const SizedBox(width: 8),
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
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(CupertinoIcons.calendar, size: 18),
                  const SizedBox(width: 8),
                  if (widget.performance.startDate ==
                      widget.performance.endDate)
                    Expanded(
                      child: Text(
                        '${widget.performance.startDate}' ?? 'Unknown',
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

  Widget InfoDetailImgs() {
    List<String>? imgUrls = widget.performance.imgs;
    String poster = widget.performance.poster.toString() ?? "";

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
