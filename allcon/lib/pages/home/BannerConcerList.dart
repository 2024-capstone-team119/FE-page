import 'package:allcon/utils/Colors.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/pages/concert/PerformaceDetail.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerConcerList extends StatefulWidget {
  final List<Performance> performances;

  const BannerConcerList({super.key, required this.performances});

  @override
  State<BannerConcerList> createState() => _BannerConcerListState();
}

class _BannerConcerListState extends State<BannerConcerList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: Swiper(
        itemCount: 8,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: MediaQuery.of(context).size.height,
        layout: SwiperLayout.TINDER,
        loop: true,
        autoplay: true,
        autoplayDelay: 6000,
        autoplayDisableOnInteraction: true,
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: midGray,
            activeSize: 10,
            space: 4,
          ),
        ),
        itemBuilder: (context, index) {
          Performance performance = widget.performances[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => PerformanceDetail(performance: performance));
            },
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 380,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          color: Colors.white,
                          child: Image.network(
                            performance.poster ?? "",
                            fit: BoxFit.fill,
                            height: 500,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
