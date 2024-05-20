import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImgController extends GetxController {
  static ImgController get to => Get.find();

  Future<File?> selectImg() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return null;
    }
    return File(pickedFile.path);
  }
}
