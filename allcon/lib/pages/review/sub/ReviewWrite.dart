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
  List<String> multiImage = []; // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
  List<String> images = []; // 가져온 사진들을 보여주기 위한 변수

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    if (images.length >= 5) {
      customShowToast('사진은 최대 5장까지 첨부할 수 있습니다.', context);
      return;
    }
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        multiImage = pickedFiles.map((file) => file.path).toList();
        images.addAll(multiImage);
        if (images.length > 5) {
          images = images.sublist(0, 5);
        }
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
                      height: 5.0,
                    ),
                    ReviewUploadPhoto(images: images),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReviewUploadButton(
                          onPressed: images.length < 5
                              ? () async => await _pickImage()
                              : () {},
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
}
