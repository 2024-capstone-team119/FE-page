import 'package:allcon/Data/Concert.dart';
import 'package:allcon/Data/Sample/concert_sample.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class BannerConcerList extends StatefulWidget {
  const BannerConcerList({super.key});

  @override
  State<BannerConcerList> createState() => _BannerConcerListState();
}

class _BannerConcerListState extends State<BannerConcerList> {
  List<Concert> bannerConcert = bannerConcertSample;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      // color: Colors.lime,
      child: Swiper(
        itemCount: bannerConcert.length,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: MediaQuery.of(context).size.height,
        layout: SwiperLayout.TINDER,
        loop: true,
        autoplay: true,
        autoplayDelay: 6000,
        autoplayDisableOnInteraction: true,
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Color(0xFFEDEBEB),
            // activeColor: Colors.lightBlueAccent,
            activeSize: 10,
            space: 4,
          ),
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print('배너 클릭 성공');
              /* Get.to(
                 
              );*/
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
                            bannerConcertSample[index].imgUrl ?? "",
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
}
