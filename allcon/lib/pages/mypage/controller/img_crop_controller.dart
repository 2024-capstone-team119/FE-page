import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

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
      cropStyle: CropStyle.circle,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile == null) {
      return null;
    }

    final resizedImage = img.decodeImage(await croppedFile.readAsBytes())!;
    final resized = img.copyResize(resizedImage, width: 120, height: 120);
    final resizedBytes = img.encodeJpg(resized);

    final directory = await getTemporaryDirectory();
    final resizedFile = File('${directory.path}/resized.jpg')
      ..writeAsBytesSync(resizedBytes);

    return resizedFile;
  }
}
