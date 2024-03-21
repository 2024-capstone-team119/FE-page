import 'package:allcon/Util/Theme.dart';
import 'package:flutter/material.dart';
import 'package:allcon/Pages/Seat/seat_review.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class SeatWrite extends StatefulWidget {
  const SeatWrite({super.key});

  @override
  State<SeatWrite> createState() => _SeatWriteState();
}

class _SeatWriteState extends State<SeatWrite> {
  int selectedStar = 0;
  int reviewId = 0;
  late String currentTime;
  final TextEditingController _textController = TextEditingController();

  void _submitReview(Review newReview) {
    setState(() {
      reviewList.add(newReview);
    });
    reviewId++;
  }

  late FToast fToast;

  final picker = ImagePicker();
  List<XFile?> multiImage = []; // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
  List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

  @override
  // 초기화
  void initState() {
    super.initState();
    currentTime = _getCurrentDate();
    fToast = FToast();
    fToast.init(context);
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled =
        selectedStar > 0 && _textController.text.length >= 10;

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
                        const Text(
                          'A구역',
                          style: TextStyle(fontSize: 20.0),
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
                                      ? Colors.yellow
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
                    height: 3.0,
                  ),
                  uploadPhoto(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      uploadButton(
                        onPressed: () async {
                          multiImage = await picker.pickMultiImage();
                          setState(() {
                            //multiImage를 통해 갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                            images.addAll(multiImage);
                          });
                        },
                        icon: Icons.add_photo_alternate,
                        label: '사진 첨부하기',
                      ),
                      uploadButton(
                        onPressed: isButtonEnabled
                            ? () {
                                _submitReview(
                                  Review(
                                    id: reviewId,
                                    name: 'noname$reviewId',
                                    star: selectedStar,
                                    text: _textController.text,
                                    createTime: currentTime,
                                    good: 0,
                                    bad: 0,
                                  ),
                                );
                                Navigator.of(context).pop();
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

  Widget uploadPhoto() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: GridView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: images.length, // 보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // 한 행에 보여줄 사진 개수
          childAspectRatio: 1 / 1, // 사진의 가로 세로 비율
          mainAxisSpacing: 10, // 수평 Padding
          crossAxisSpacing: 10, // 수직 Padding
        ),
        itemBuilder: (BuildContext context, int index) {
          // 사진 삭제 버튼을 표시하기 위해 Stack을 사용함
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(images[index]!
                              .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                          ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.close, color: Colors.white, size: 15),
                  onPressed: () {
                    setState(() {
                      images.remove(images[index]);
                    });
                  },
                ), //삭제 버튼
              ),
            ],
          );
        },
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
