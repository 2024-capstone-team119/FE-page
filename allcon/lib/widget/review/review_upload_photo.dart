import 'dart:io';
import 'package:flutter/material.dart';

class ReviewUploadPhoto extends StatefulWidget {
  List<String>? images;

  ReviewUploadPhoto({super.key, this.images});

  @override
  State<ReviewUploadPhoto> createState() => _ReviewUploadPhotoState();
}

class _ReviewUploadPhotoState extends State<ReviewUploadPhoto> {
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
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.file(
                          File(widget.images![index]),
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
                          setState(() {
                            widget.images!.removeAt(index);
                          });
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
