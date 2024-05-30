import 'dart:io';
import 'package:flutter/material.dart';

class ReviewUploadPhoto extends StatefulWidget {
  final List<String>? images;
  final Function(List<String>)? onDelete;

  const ReviewUploadPhoto({
    super.key,
    this.images,
    this.onDelete,
  });

  @override
  State<ReviewUploadPhoto> createState() => _ReviewUploadPhotoState();
}

class _ReviewUploadPhotoState extends State<ReviewUploadPhoto> {
  // 이미지 삭제 메서드
  void _removeImage(int index) {
    setState(() {
      widget.images!.removeAt(index); // 이미지 삭제
      if (widget.onDelete != null) {
        widget.onDelete!(widget.images!); // 삭제된 이미지 목록을 상위 위젯으로 전달
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.images == null || widget.images!.isEmpty)
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // 한 행에 보여줄 사진 개수
                childAspectRatio: 1 / 1, // 사진의 가로 세로 비율
                mainAxisSpacing: 10, // 수평 Padding
                crossAxisSpacing: 10, // 수직 Padding
              ),
              itemCount: widget.images!.length,
              itemBuilder: (context, index) {
                String imageUrl = widget.images![index];
                bool isLocal = !imageUrl.startsWith('http'); // 로컬 이미지 체크
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: isLocal
                            ? Image.file(
                                File(imageUrl),
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              )),
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
                        icon: const Icon(Icons.close,
                            color: Colors.white, size: 15),
                        onPressed: () {
                          _removeImage(index); // 이미지 삭제 메서드 호출
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
