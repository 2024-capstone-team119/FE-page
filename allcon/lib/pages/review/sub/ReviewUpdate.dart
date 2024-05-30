import 'package:allcon/model/review_model.dart';
import 'package:allcon/service/review/myReviewService.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:allcon/widget/review/custom_show_toast.dart';
import 'package:allcon/widget/review/review_upload_button.dart';
import 'package:allcon/widget/review/review_upload_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReviewUpdate extends StatefulWidget {
  final String userId;
  final String userNickname;
  final Review review;
  final List<Zone> zones;
  final VoidCallback reloadCallback;

  const ReviewUpdate({
    super.key,
    required this.userId,
    required this.userNickname,
    required this.review,
    required this.zones,
    required this.reloadCallback,
  });

  @override
  State<ReviewUpdate> createState() => _ReviewUpdateState();
}

class _ReviewUpdateState extends State<ReviewUpdate> {
  late String reviewId;
  String? selectedZoneId;
  String? selectedZoneName;
  late int selectedStar;

  late String currentTime;
  late TextEditingController _textController;

  final picker = ImagePicker();
  List<String> multiImage = []; // 갤러리에서 여러 장의 사진을 선택
  List<String> images = []; // 가져온 사진들을 보여주기 위한 변수

  Future<void> _pickImage() async {
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        images.addAll(pickedFiles.map((file) => file.path).toList());
      });
    } else {
      print('No images selected.');
    }
  }

  @override
  void initState() {
    super.initState();
    reviewId = widget.review.reviewId;
    selectedZoneId = widget.review.zoneId;
    selectedStar = widget.review.rating;
    _textController = TextEditingController(text: widget.review.text);
    images = List.from(widget.review.image);
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = _textController.text.length >= 10;

    List<String> zoneNames =
        widget.zones.map((zone) => zone.zoneName!).toList();

    if (selectedZoneName == null && zoneNames.isNotEmpty) {
      selectedZoneName = zoneNames.first;
      selectedZoneId = widget.zones
          .firstWhere((zone) => zone.zoneName == selectedZoneName)
          .zoneId;
    }

    return Container(
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
                        CustomDropdownButton(
                          items: zoneNames,
                          value: selectedZoneName ?? '',
                          onChanged: (String? newValue) async {
                            if (newValue != null) {
                              setState(() {
                                selectedZoneName = newValue;
                                selectedZoneId = widget.zones
                                    .firstWhere(
                                        (zone) => zone.zoneName == newValue)
                                    .zoneId;
                              });
                            }
                          },
                        ),
                        Row(
                          children: [
                            for (int i = 1; i < 6; i++)
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedStar = i;
                                  });
                                },
                                icon: Icon(
                                  CupertinoIcons.star_fill,
                                  color: i <= selectedStar
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
                    height: 3.0,
                  ),
                  ReviewUploadPhoto(
                    images: images,
                    onDelete: (deletedImages) {
                      setState(() {
                        images = deletedImages; // 삭제된 이미지 목록 업데이트
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ReviewUploadButton(
                        onPressed: _pickImage,
                        icon: Icons.add_photo_alternate,
                        label: '사진 수정하기',
                      ),
                      ReviewUploadButton(
                        onPressed: isButtonEnabled
                            ? () async {
                                await MyReviewService.updateReview(
                                  widget.review.reviewId,
                                  widget.userId,
                                  widget.userNickname,
                                  _textController.text,
                                  selectedZoneId ?? widget.review.zoneId,
                                  images,
                                  selectedStar,
                                );
                                Navigator.pop(context);
                                widget.reloadCallback();
                              }
                            : () {
                                FocusScope.of(context).unfocus(); // 키보드 숨기기

                                customShowToast('10글자 이상의 리뷰를 작성해주세요', context);
                              }, // 버튼 비활성화
                        icon: CupertinoIcons.pen,
                        label: '리뷰 수정하기',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
