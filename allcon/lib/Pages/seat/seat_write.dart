import 'package:flutter/material.dart';
import 'package:allcon/Pages/Seat/seat_review.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        color: Color.fromARGB(255, 238, 225, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
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
                                  Icons.star_outlined,
                                  color: i <= selectedStar
                                      ? Colors.yellow
                                      : Colors.white,
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
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    onChanged: (_) {
                      setState(() {}); // 텍스트 입력 시 상태 갱신
                    },
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  uploadButton(
                    onPressed: () {},
                    icon: Icons.camera_alt_rounded,
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
                              _showToast('별점을 남겨주세요.');
                            } else {
                              _showToast('10글자 이상의 리뷰를 작성해주세요.');
                            }
                          }, // 버튼 비활성화
                    icon: Icons.edit,
                    label: '리뷰 등록하기',
                  ),
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
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(label),
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
            Icons.priority_high,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            alert,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.0,
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
