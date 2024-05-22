import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:allcon/model/review_model.dart';
import 'package:allcon/service/review/myReviewService.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ReviewUpdate extends StatefulWidget {
  final String userId;
  final Review review;
  final List<Zone> zones;
  final VoidCallback reloadCallback;

  const ReviewUpdate({
    super.key,
    required this.userId,
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

  late FToast fToast;

  final picker = ImagePicker();
  Uint8List? _imageBytes;

  Future<void> _fetchImage() async {
    if (widget.review.image != null && widget.review.image!.isNotEmpty) {
      setState(() {
        _imageBytes = base64Decode(widget.review.image!);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageBytes = File(image.path).readAsBytesSync();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    reviewId = widget.review.reviewId;
    selectedZoneId = widget.review.zoneId;
    selectedStar = widget.review.rating;
    _textController = TextEditingController(text: widget.review.text);
    fToast = FToast();
    fToast.init(context);
    _fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled =
        selectedStar > 0 && _textController.text.length >= 10;

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
                  updatePhoto(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      uploadButton(
                        onPressed: _pickImage,
                        icon: Icons.add_photo_alternate,
                        label: '사진 수정하기',
                      ),
                      uploadButton(
                        onPressed: isButtonEnabled
                            ? () async {
                                await MyReviewService.updateReview(
                                    widget.review.reviewId,
                                    widget.userId,
                                    _textController.text,
                                    selectedStar);
                                Navigator.pop(context);
                                widget.reloadCallback();
                              }
                            : () {
                                FocusScope.of(context).unfocus(); // 키보드 숨기기
                                if (selectedStar == 0) {
                                  _showToast('별점을 남겨주세요 ');
                                } else {
                                  _showToast('10글자 이상의 리뷰를 작성해주세요');
                                }
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

  Widget uploadButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        backgroundColor: lightlavenderColor,
        elevation: 0.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 25.0),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget updatePhoto() {
    return _imageBytes == null
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(_imageBytes!),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 15),
                    onPressed: () {
                      setState(() {
                        _imageBytes = null; // 이미지 삭제
                      });
                    },
                  ),
                ),
              ],
            ),
          );
  }

  _showToast(String alert) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.deepPurpleAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            size: 20.0,
            CupertinoIcons.exclamationmark,
            color: Colors.white,
          ),
          Text(
            alert,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
