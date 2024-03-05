// import 'package:allcon/Data/Content.dart';
// import 'package:allcon/Pages/Community/Sub/GetPost.dart';
// import 'package:allcon/Pages/Community/Sub/content_controller.dart';
// import 'package:allcon/Widget/app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';
//
// class MyContentLikes extends StatelessWidget {
//   final ContentController contentController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     List<Content> likedContents =
//         contentController.contents.where((content) => content.isLike).toList();
//
//     return Scaffold(
//       appBar: const MyAppBar(text: '커뮤니티'),
//       backgroundColor: Colors.white,
//       body: ListView.builder(
//         itemCount: likedContents.length,
//         itemBuilder: (context, index) {
//           return _buildContentItem(likedContents[index]);
//         },
//         scrollDirection: Axis.vertical,
//       ),
//     );
//   }
//
//   Widget _buildContentItem(Content content) {
//     DateTime dateTime = content.date ?? DateTime.now();
//     return GestureDetector(
//       onTap: () {
//         Get.to(() => MyContentDetail(content: content));
//       },
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               color: Colors.white,
//               height: 80.0,
//               child: Row(
//                 children: [
//                   const SizedBox(width: 20.0),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           content.title ?? "",
//                           style: const TextStyle(
//                               fontSize: 18.0, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 4.0),
//                         Row(
//                           children: [
//                             Text(
//                               "${DateFormat('yyyy-MM-dd').format(dateTime)}",
//                               style: TextStyle(
//                                 fontSize: 12.0,
//                               ),
//                             ),
//                             SizedBox(width: 8.0),
//                             Text(
//                               "${DateFormat('HH:mm').format(dateTime)}",
//                               style: TextStyle(
//                                 fontSize: 12.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 4.0),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.favorite,
//                               color: Colors.red[300],
//                               size: 16.0,
//                             ),
//                             const SizedBox(width: 4.0),
//                             Text(
//                               "${content.like}",
//                               style: TextStyle(
//                                 color: Colors.red[300],
//                               ),
//                             ),
//                             const SizedBox(width: 8.0),
//                             Icon(
//                               CupertinoIcons.chat_bubble,
//                               color: Colors.blueAccent,
//                               size: 16.0,
//                             ),
//                             const SizedBox(width: 4.0),
//                             Text(
//                               "${content.comment?.length ?? 0}",
//                               style: TextStyle(
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     iconSize: 30.0,
//                     icon: Icon(
//                       content.isLike
//                           ? CupertinoIcons.heart_fill
//                           : CupertinoIcons.heart,
//                       color: content.isLike ? Colors.redAccent : Colors.grey,
//                     ),
//                     onPressed: () {
//                       contentController.toggleLike(content.postId);
//                     },
//                   ),
//                   const SizedBox(width: 16.0),
//                 ],
//               ),
//             ),
//           ),
//           Container(height: 1.0, color: Colors.grey[300]),
//         ],
//       ),
//     );
//   }
// }
