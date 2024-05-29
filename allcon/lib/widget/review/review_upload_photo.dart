import 'dart:io';
import 'package:flutter/material.dart';

class ReviewUploadPhoto extends StatefulWidget {
  List<File>? images;

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
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(widget.images![index].path)),
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
