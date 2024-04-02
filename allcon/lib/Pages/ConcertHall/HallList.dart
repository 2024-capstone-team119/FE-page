import 'package:flutter/material.dart';
import 'package:allcon/model/place_model.dart';
import 'package:allcon/service/api.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Pages/Seat/seat_main.dart';
import 'HallSearch.dart';

class HallList extends StatelessWidget {
  final String area;

  const HallList({super.key, this.area = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Api.getPlace(area),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('데이터 없음');
          } else {
            List<Place> selectedList = snapshot.data!;

            void cardClickEvent(BuildContext context, String content) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SeatMain(title: content)),
              );
            }

            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(
                  //     '목록',
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // if (searchText.isEmpty ||
                        //     selectedList[index]
                        //         .title
                        //         .toLowerCase()
                        //         .contains(searchText.toLowerCase()))
                        {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(selectedList[index].name ??
                                    "해당하는 공연장이 없습니다."),
                                onTap: () {
                                  cardClickEvent(context,
                                      selectedList[index].name ?? "해당하는");
                                },
                                leading: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.deepPurple,
                                    ),
                                    width: 5.0,
                                    height: 30.0,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                                child: Divider(),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
