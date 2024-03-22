import 'package:allcon/Data/Concert.dart';
import 'package:allcon/Pages/Concert/PerformaceDetail.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerConcerList extends StatefulWidget {
  const BannerConcerList({Key? key}) : super(key: key);

  @override
  State<BannerConcerList> createState() => _BannerConcerListState();
}

class _BannerConcerListState extends State<BannerConcerList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Performance>>(
      future: Api.getPerformanceNew(),
      builder: (context, AsyncSnapshot<List<Performance>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No performances available.');
        } else {
          List<Performance> performances = snapshot.data!;
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
                Performance performance = performances[index];
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
                                  fit: BoxFit.cover,
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
      },
    );
  }
}
