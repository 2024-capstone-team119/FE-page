import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class ImgController extends GetxController {
  static ImgController get to => Get.find();

  Future<File?> selectImg() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return null;
    }

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      cropStyle: CropStyle.circle,
    );

    if (croppedFile == null) {
      return null;
    }

    // 리사이징
    final tempDir = await getTemporaryDirectory();
    final uniqueId = DateTime.now().millisecondsSinceEpoch;
    final resizedFile = File('${tempDir.path}/$uniqueId.jpg');

    final resizedImage = img.decodeImage(await croppedFile.readAsBytes());
    final resized = img.copyResize(resizedImage!, width: 100);
    resizedFile.writeAsBytesSync(img.encodeJpg(resized, quality: 90));

    return resizedFile;
  }
}
