import 'dart:io';

import 'package:allcon/service/review/reviewService.dart';
import 'package:allcon/widget/review/custom_show_toast.dart';
import 'package:allcon/widget/review/review_upload_button.dart';
import 'package:allcon/widget/review/review_upload_photo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

class ReviewWrite extends StatefulWidget {
  final String zoneId;
  final String zoneName;
  final String userId;
  final String userNickname;

  const ReviewWrite({
    super.key,
    required this.zoneId,
    required this.zoneName,
    required this.userId,
    required this.userNickname,
  });

  @override
  State<ReviewWrite> createState() => _ReviewWriteState();
}

class _ReviewWriteState extends State<ReviewWrite> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  late int _rating = 3;

  final picker = ImagePicker();
  List<File> multiImage = []; // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
  List<File> images = []; // 가져온 사진들을 보여주기 위한 변수

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        multiImage = pickedFiles.map((file) => File(file.path)).toList();
        images.addAll(multiImage);
      });
    } else {
      print('No images selected.');
    }
  }

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      String reviewText = _textController.text;
      String zoneId = widget.zoneId;
      int rating = _rating;

      if (widget.userId == '' || widget.userNickname == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      bool success = await ReviewService.addReview(widget.userId,
          widget.userNickname, reviewText, rating, zoneId, images);
      if (success) {
        Navigator.pop(context);
      } else {
        // Handle submission failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit review')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = _rating > 0 && _textController.text.length >= 10;

    return Form(
      key: _formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.zoneName}구역',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          Row(
                            children: [
                              for (int i = 1; i < 6; i++)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _rating = i;
                                    });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.star_fill,
                                    color: i <= _rating
                                        ? Colors.amberAccent
                                        : Colors.black12,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      controller: _textController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: '10글자 이상의 리뷰를 작성해주세요.',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.black87),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.black87),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      onChanged: (_) {
                        setState(() {}); // 텍스트 입력 시 상태 갱신
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ReviewUploadPhoto(images: images),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReviewUploadButton(
                          onPressed: _pickImage,
                          icon: Icons.add_photo_alternate,
                          label: '사진 첨부하기',
                        ),
                        ReviewUploadButton(
                          onPressed: isButtonEnabled
                              ? () {
                                  _submitReview();
                                }
                              : () {
                                  FocusScope.of(context).unfocus(); // 키보드 숨기기
                                  if (_rating == 0) {
                                    customShowToast('별점을 남겨주세요 ', context);
                                  } else {
                                    customShowToast(
                                        '10글자 이상의 리뷰를 작성해주세요', context);
                                  }
                                }, // 버튼 비활성화
                          icon: CupertinoIcons.pen,
                          label: '리뷰 등록하기',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget uploadPhoto() {
  //   return Container(
  //     margin: const EdgeInsets.all(10),
  //     child: GridView.builder(
  //       padding: const EdgeInsets.all(0),
  //       shrinkWrap: true,
  //       itemCount: images.length, // 보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 5, // 한 행에 보여줄 사진 개수
  //         childAspectRatio: 1 / 1, // 사진의 가로 세로 비율
  //         mainAxisSpacing: 10, // 수평 Padding
  //         crossAxisSpacing: 10, // 수직 Padding
  //       ),
  //       itemBuilder: (BuildContext context, int index) {
  //         // 사진 삭제 버튼을 표시하기 위해 Stack을 사용함
  //         return Stack(
  //           alignment: Alignment.topRight,
  //           children: [
  //             Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(5),
  //                 image: DecorationImage(
  //                   fit: BoxFit.cover,
  //                   image: FileImage(
  //                     File(images[index]!
  //                             .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
  //                         ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.black,
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               child: IconButton(
  //                 padding: EdgeInsets.zero,
  //                 constraints: const BoxConstraints(),
  //                 icon: const Icon(Icons.close, color: Colors.white, size: 15),
  //                 onPressed: () {
  //                   setState(() {
  //                     images.remove(images[index]);
  //                   });
  //                 },
  //               ), //삭제 버튼
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }
}
