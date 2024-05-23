import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReviewUploadPhoto extends StatefulWidget {
  XFile? imageFile;
  Uint8List? imageBytes;
  final bool isUpdate;

  ReviewUploadPhoto({
    super.key,
    this.imageFile,
    this.imageBytes,
    required this.isUpdate,
  });

  @override
  State<ReviewUploadPhoto> createState() => _ReviewUploadPhotoState();
}

class _ReviewUploadPhotoState extends State<ReviewUploadPhoto> {
  @override
  Widget build(BuildContext context) {
    return (widget.isUpdate && widget.imageBytes == null) ||
            (!widget.isUpdate && widget.imageFile == null)
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
                      image: widget.isUpdate
                          ? MemoryImage(widget.imageBytes!)
                              as ImageProvider<Object>
                          : FileImage(
                              File(widget.imageFile!.path),
                            ) as ImageProvider<Object>,
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
                        widget.isUpdate
                            ? widget.imageBytes = null
                            : widget.imageFile = null;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
