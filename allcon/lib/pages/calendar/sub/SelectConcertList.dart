import 'package:allcon/pages/concert/PerformaceDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:allcon/utils/Colors.dart';
import '../controller/selecetedDay_controller.dart';

class SelectConcertList extends StatefulWidget {
  const SelectConcertList({super.key});

  @override
  State<SelectConcertList> createState() => _SelectConcertListState();
}

class _SelectConcertListState extends State<SelectConcertList> {
  final SelectedDayController _dayController =
      Get.find<SelectedDayController>();
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectedDayController>(
      builder: (_) {
        final selectedDayEvents = _dayController.performances;

        if (selectedDayEvents.isEmpty) {
          return const SizedBox.shrink();
        }

        final displayedEvents =
            _showMore ? selectedDayEvents : selectedDayEvents.take(4).toList();

        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: displayedEvents.asMap().entries.map((entry) {
                      final index = entry.key;
                      final performance = entry.value;
                      final backgroundColor =
                          index.isEven ? lavenderColor : Mint.withOpacity(0.1);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PerformanceDetail(
                                performance: performance,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.93,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 16.0,
                          ),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(CupertinoIcons.music_note_list),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      performance.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                if (selectedDayEvents.length > 4)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _showMore = !_showMore;
                          });
                        },
                        icon: _showMore
                            ? const Icon(CupertinoIcons.chevron_compact_up)
                            : const Icon(CupertinoIcons.chevron_compact_down),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:allcon/utils/Colors.dart';
// import '../controller/selecetedDay_controller.dart';

// class SelectConcertList extends StatefulWidget {
//   const SelectConcertList({super.key});

//   @override
//   State<SelectConcertList> createState() => _SelectConcertListState();
// }

// class _SelectConcertListState extends State<SelectConcertList> {
//   final SelectedDayController _dayController =
//       Get.find<SelectedDayController>();
//   bool _showMore = false;

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SelectedDayController>(
//       builder: (_) {
//         final selectedDayEvents = _dayController.performances;

//         if (selectedDayEvents.isEmpty) {
//           return const SizedBox.shrink();
//         }

//         final displayedEvents =
//             _showMore ? selectedDayEvents : selectedDayEvents.take(4).toList();

//         return Theme(
//           data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//           child: Container(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: displayedEvents.asMap().entries.map((entry) {
//                       final index = entry.key;
//                       final performance = entry.value;
//                       final backgroundColor =
//                           index.isEven ? lavenderColor : Mint.withOpacity(0.1);

//                       return Container(
//                         width: MediaQuery.of(context).size.width * 0.93,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 10.0,
//                           horizontal: 16.0,
//                         ),
//                         margin: const EdgeInsets.only(bottom: 8.0),
//                         decoration: BoxDecoration(
//                           color: backgroundColor,
//                           borderRadius: BorderRadius.circular(40.0),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 const Icon(CupertinoIcons.music_note_list),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     performance.name ?? '',
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 if (selectedDayEvents.length > 4)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             _showMore = !_showMore;
//                           });
//                         },
//                         icon: _showMore
//                             ? const Icon(CupertinoIcons.chevron_compact_up)
//                             : const Icon(CupertinoIcons.chevron_compact_down),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
